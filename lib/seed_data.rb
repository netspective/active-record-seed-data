module SeedData

    class SeedColumnMissing < Exception
    end
    
    def self.included(base)
        base.extend ClassMethods
    end
 
    module ClassMethods

        def create_or_update_seed(options = {})
            seed_info = options.delete(:SEED) || { :key => "seed_name" }
            keys = seed_info[:keys] || seed_info[:key]
            keys = [keys] if keys.is_a?(String)  # in case it's just one column, convert it to an array         

            # make sure each seed key value's column is present (it's ok to be Nil, it just must be present)
            keys.each do |c|
              unless options[c].exists?
                raise SeedColumnMissing, "Seed column #{c} is missing from seed data in #{self.class.name}.create_or_update_seed(#{options.keys.join(', ')})."
              end
            end

            updated = true
            record = find(:first, :conditions => [keys.collect {|k| options[c].nil ? "#{c} is NULL" : "#{c} = ?" }.join(" AND "), keys.select{|c| options[c].nil ? false : options[c]} ])
            if ! record 
                record = new
                updated = false
            end
            record.id = id
            record.attributes = options

            # run through the passed in attributes and see if there's anything dynamic required for any of them
            eval_code = ""
            options.each_pair {|k,v|
                if(v.match(/^EVAL:(.*)/))
                    eval_code += "record.#{k} = #{$1}\n";  # prepare the eval string with some ruby code
                end            
            }
            eval(eval_code) if eval_code

            record.save!    

            if seed_info[:log].exists?            
                seed_info[:log].push("#{updated ? 'Updated' : 'Created'} #{record.class.name} seed for #{keys.join(', ')} = #{keys.collect{|k| options[k]}.join(', ')}.")
            end

            record
        end

    end
  
end

class ActiveRecord::Base
    include SeedData
end
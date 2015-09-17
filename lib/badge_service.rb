require 'badges'

class BadgeService
  
  DEFAULT_SCALE = 100/24.0
  
  def create(base, size: 100, **options)
    options[:lean] ||= false
  
    badge_data = $badges[base.to_sym]
    
    Rasem::SVGImage.new(width: size, height: size, lean: options[:lean]) do
      if badge_data
        defs do      
          group(id: base) do
            instance_eval badge_data
          end
        end      
      end
      group do
        if badge_data
          use(base)
        else
          circle(11,11,10, fill: "#f90", stroke: "#f90", opacity: 1.0)
          circle(11,11,10, fill: "transparent", stroke_width: 2, stroke: '#fff', opacity: 0.35 )    
        end
        if options[:friend]
          circle(11,11,10, fill: 'transparent', stroke_width: 2, stroke: '#FFE73D', opacity: 1.0)
        end
      end.scale(DEFAULT_SCALE * size/100.0) 
    end
  end
end

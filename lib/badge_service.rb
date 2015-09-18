require 'badges'

class BadgeService
  
  DEFAULT_SCALE = 100/24.0
  BADGE_COLORS = {
    human: '#2b73b1',
    vampire: '#c80103',
    werewolf: '#8c6239',
    zombie: '#7bac38',
    traitor: '#433'
  }
  
  def create(base, size: 100, **options)
    options[:lean] ||= false
  
    badge_data = $badges[base.to_sym]
    
    color = BADGE_COLORS[base.to_sym] || '#f90'
    
    Rasem::SVGImage.new(width: size, height: size, lean: options[:lean]) do
      if badge_data
        instance_eval badge_data
      end
      group do
        circle(11.9,11.9,12, fill: color, stroke_width: 0, opacity: 1.0 )
        if badge_data
          use('badge').scale(1.5).translate(-1.9,-1.9)
        end
        if options[:friend]
          circle(11.9,11.9,11, fill: 'transparent', stroke: '#FFE73D', stroke_width: 2 , opacity: 1)
        else
          circle(11.9,11.9,11, fill: 'transparent', stroke: '#383333', stroke_width: 2, opacity: 0.5 )
        end
      end.scale(DEFAULT_SCALE * size/100.0) 
    end
  end
end

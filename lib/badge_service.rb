require 'badges'

class BadgeService
  include Singleton

  DEFAULT_SCALE = 100/24.0
  BADGE_COLORS = {
    human: '#2b73b1',
    vampire: '#c80103',
    werewolf: '#8c6239',
    zombie: '#7bac38',
    traitor: '#433',
    civilian: '#888'
  }

  def create(base, **options)
    if options[:tile]
      badge_tile(base, options)
    else
      just_a_badge(base, options)
    end
  end

  def badge_tile(base, options = {} )
    size = options[:size]
    badge_size = options[:badge_size].to_i
    badge_size = (size * 0.33) if badge_size == 0
    badge_data = $badges[base.to_sym]

    offset = (50 - ((badge_size/size) / 2.0)) - badge_size/2.0

    color = BADGE_COLORS[base.to_sym] || '#f90'
    Rasem::SVGImage.new(width: size, height: size) do
      defs do
        mask(id: 'Mask') do
          rectangle( -1, -1, 102, 102, fill: 'white')
        end
      end
      group do
        #rectangle( -1, -1, 102, 102,  fill: 'blue')

        group id: 'int', mask: 'url(#Mask)' do
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
          end.translate(offset,offset).scale(DEFAULT_SCALE * badge_size/100.0)


        end
      end.scale(size/100.0,size/100.0)
    end
  end

  def just_a_badge(base, options = {})
    size = options[:size]
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

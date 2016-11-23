class DotService
  include Singleton

  DEFAULT_SCALE = 100/85.0
  DEFAULT_COLOR = '#DDDCBF'

  def create(count, team: 0, friends: 0, faction: 0, size: 100, **options)
    
    count = count.to_i
    circles = true
    
    x = 7
    y = 88
    total_count = team + friends + count + faction
    y = 80 if (total_count > 10)
    index = 0
    radius = 6
    x_inc = radius / 2.0
    color = 'black'
    team_color = 'white'
    friend_color = 'yellow'
    faction_color = 'cyan'
    
    total_count = team + friends + count + faction
    if total_count > 20
      scale = 20.0 / total_count
      friends = (friends * scale).round
      team    = (team * scale).round
      faction = (faction * scale).round
      count   = 20 - (friends + team + faction)
      
      total_count = 20
      circles = false
    end
        
    # the maximum number of dots is 20?
    
    Rasem::SVGImage.new(width: size, height: size) do
      defs do
        mask(id: 'Mask') do
          rectangle( -1, -1, 102, 102,fill: 'white')
        end
      end
      group do        
        group id: 'int', mask: 'url(#Mask)' do
          
          while index < total_count
            dot_color = color
            if (friends > 0)
              dot_color = friend_color
              friends -= 1
            elsif (faction > 0)
              dot_color = faction_color
              faction -= 1
            elsif (team > 0)
              dot_color = team_color
              team -= 1
            end
            if circles
              rectangle( x, y, radius, radius, rx:radius/2.0, ry:radius/2.0, 
                fill: dot_color, stroke: dot_color, opacity: 1.0, stroke_width: 0) 
            else
              rectangle( x, y, radius, radius, 
                fill: dot_color, stroke: dot_color, opacity: 1.0, stroke_width: 0) 
            end
            x += x_inc + radius
            index += 1
            if index == 10
              x = 7
              y += x_inc + radius
            end
          end
          
        end
      end.scale(size/100.0,size/100.0)
    end
      
  end
end
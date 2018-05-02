require 'tiles'

class TileService
  include Singleton

  DEFAULT_SCALE = 100.0/85
  DEFAULT_COLOR = '#DDDCBF'

  def create(base, color, size: 100, **options)

    color = DEAFULT_COLOR if color.blank? || color.size == 1
    badge_offset = 23
    badge_start_x = 15
    badge_start_y = 15
    options[:lean] ||= false
    vflip = options[:vflip] ? -1 : 1
    hflip = options[:hflip] ? -1 : 1
    hoffset = hflip == -1 ? size : 0
    voffset = vflip == -1 ? size : 0
    highlight = options[:highlight].present?

    owner_percent = options[:owner_percent].to_i
    if owner_percent > 0
      owner_color = "##{options[:owner_color]}"
      if owner_percent >= 100
        color = owner_color
        owner_percent = 0
      end
      owner_percent /= 100.0
    end
    color = color[1..99] if color[1] == '#'

    tile_data = $tiles[base.to_sym]

    #puts "#{base} R:#{options[:rotation]} V:#{vflip} H:#{hflip} C:#{color} Z:#{size} #{tile_data ? '...' : '!!!'}"
    Rasem::SVGImage.new(width: size, height: size, lean: options[:lean]) do
      defs do
        mask(id: 'Mask') do
          rectangle( -1, -1, 102, 102,fill: 'white')
        end

        if tile_data
          group(id: base) do
            instance_eval tile_data
          end
        end

        if options[:special]
          special = Tile.where(name: 'special').first
          if special
            group(id: special.name) do
              instance_eval special.svg_data
            end
          end
        end

      end
      group do
        group id: 'int', mask: 'url(#Mask)' do
          rectangle( -1, -1, 102, 102,  fill: color)

          offset = (owner_percent * 1.4 * 50)
          radius = (owner_percent * 1.4 * 100)
          if owner_percent > 0 && owner_percent < 100
            rectangle(50 - offset,50 - offset,radius,radius, rx:radius/2, ry:radius/2,
              fill: owner_color, stroke: owner_color, opacity: 1.0, stroke_width: 0)
            rectangle(50 - offset,50 - offset,radius,radius, rx:radius/2, ry:radius/2,
              fill: :transparent, stroke: :black, stroke_width: 3, opacity: 0.33)
          end

          if options[:special]
            special_color = "##{options[:special]}"
            use('special', fill: special_color, opacity: 0.3).scale(DEFAULT_SCALE)
          end

          group id: 'building' do
            if tile_data
              use(base).scale(DEFAULT_SCALE)
            elsif base.downcase != 'blank'
              text(50, 33, fill: "black",
                'text-anchor' => 'middle',
                'alignment-baseline' => 'central',
                'font-family' => 'Century Gothic, Verdana, Helvetica, Arial, sans-serif',
                'letter-spacing' => -1.5) {
                  lines(base, line_height: 16, line_break: '_')
               }
            end
          end.rotate(options[:rotation], size/4.0, size/4.0)

          rectangle( 0, 0, 100, 100, rx: 5, ry: 5, fill: :transparent, stroke: :black, stroke_width: 6, opacity: 0.2)
          if highlight
            rectangle( 4, 4, 92, 92, rx: 3, ry: 3, fill: :transparent, stroke: :yellow, stroke_width: 4, opacity: 0.5)
          else
          end
        end
      end.translate(hoffset,voffset).scale(hflip * size/100.0, vflip * size/100.0)
    end
  end
end
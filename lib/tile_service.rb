require 'tiles'

class TileService
  
  DEFAULT_SCALE = 100/85.0
  
  def create(base, color, size: 100, **options)
    
    badge_offset = 23
    badge_start_x = 15
    badge_start_y = 15
    options[:rotation] = options[:rotation].to_i * 90
    options[:lean] ||= false
    vflip = options[:vflip] ? -1 : 1
    hflip = options[:hflip] ? -1 : 1
    hoffset = hflip == -1 ? size : 0
    voffset = vflip == -1 ? size : 0
    
    puts "R:#{options[:rotation]} V:#{vflip} H:#{hflip} C:#{color} Z:#{size}"
    
    tile_data = $tiles[base.to_sym]
    
    Rasem::SVGImage.new(width: size, height: size, lean: options[:lean]) do
      defs do
        mask(id: 'Mask') do
          rectangle( 0, 0, 100, 100, rx: 12, ry: 12, fill: 'white')
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
          rectangle( 0, 0, 100, 100, rx: 12, ry: 12, fill: color)
          if options[:special]
            special_color = "##{options[:special]}"
            use('special', fill: special_color, stroke: special_color, opacity: 0.3).scale(DEFAULT_SCALE) 
          end
          
          use(base).scale(DEFAULT_SCALE) if tile_data

          rectangle( 0, 0, 100, 100, rx: 12, ry: 12, fill: 'transparent', stroke: 'black', stroke_width: 4, opacity: 0.2)
        end
      end.translate(hoffset,voffset).scale(hflip * size/100.0, vflip * size/100.0).rotate(options[:rotation], size/2, size/2)
    end
  end
end
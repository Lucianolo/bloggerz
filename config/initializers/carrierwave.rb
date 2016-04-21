CarrierWave.configure do |config|
  config.permissions = 0666
  config.directory_permissions = 0777
  config.storage = :file
  config.enable_processing = true
  module CarrierWave
    module MiniMagick
      # round _square_ image
      def round
        manipulate! do |img|
          img.format 'png'
          width = img[:width]-2
          radius = width/2
          mask = ::MiniMagick::Image.open img.path
          mask.format 'png'
          mask.combine_options do |m|
            m.alpha 'transparent'
            m.background 'none'
            m.fill 'white'
            m.draw 'roundrectangle 1,1,%s,%s,%s,%s' % [width, width, radius, radius]
          end
          overlay = ::MiniMagick::Image.open img.path
          overlay.format 'png'
          overlay.combine_options do |o|
            o.alpha 'transparent'
            o.background 'none'
            o.fill 'none'
            o.stroke 'white'
            o.strokewidth 2
            o.draw 'roundrectangle 1,1,%s,%s,%s,%s' % [width, width, radius, radius]
          end
          masked = img.composite(mask, 'png') do |i|
            i.alpha "set"
            i.compose 'DstIn'
          end
          masked.composite(overlay, 'png') do |i|
            i.compose 'Over'
          end
        end
      end
    end
  end
end
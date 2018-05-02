$badges = {
  human: %Q{
    defs do
      group(id: 'badge') do
        raw %Q[
          <path fill="#fff" opacity="1.00" d=" M 5.94 7.13 C 8.64 7.22 11.34 7.19 14.05 7.13 C 14.16 7.83 14.37 9.24 14.48 9.94 C 13.03 11.58 11.53 13.19 9.99 14.75 C 8.46 13.19 6.98 11.59 5.54 9.95 C 5.64 9.24 5.84 7.83 5.94 7.13 Z" />
        ]
      end
    end
  },
  vampire: %Q{
    defs do
      group(id: 'badge') do
        raw %Q[
        <path fill="#fff" opacity="1.00" d=" M 6.56 12.95 C 6.31 9.69 8.84 7.10 10.00 4.22 C 11.15 7.10 13.69 9.68 13.43 12.95 C 12.68 16.39 7.34 16.39 6.56 12.95 Z" />
        ]
      end.scale(0.7,0.8).translate(4,2)
    end
  },
  zombie: %Q{
    defs do
      group(id: 'badge') do
        raw %Q[
          <path fill="#fff" opacity="1.00" d=" M 8.36 6.31 C 11.18 4.98 14.71 7.54 13.95 10.68 C 13.75 13.97 9.24 15.00 7.08 12.93 C 5.32 11.05 5.69 7.15 8.36 6.31 M 9.17 8.25 C 7.54 8.60 8.24 11.24 9.83 10.75 C 11.46 10.40 10.76 7.75 9.17 8.25 Z" />
          <path fill="#7bac38" opacity="1.00" d=" M 9.17 8.25 C 10.76 7.75 11.46 10.40 9.83 10.75 C 8.24 11.24 7.54 8.60 9.17 8.25 Z" />
        ]
      end
    end
  },
  werewolf: %Q{
    defs do
      group(id: 'badge') do
        raw %Q[
          <path fill="#fff" opacity="1.00" d=" M 8.19 14.61 C 3.63 13.34 4.27 5.40 9.17 5.23 C 7.55 6.97 7.78 10.07 9.77 11.41 C 11.44 12.11 13.47 12.15 14.83 10.78 C 14.64 13.93 10.99 15.77 8.19 14.61 Z" />
          <path fill="#fff" opacity="1.00" d=" M 9.17 5.23 C 9.87 5.31 9.87 5.31 9.17 5.23 Z" />
          <path fill="#fff" opacity="1.00" d=" M 14.83 10.78 C 14.46 10.13 14.46 10.13 14.83 10.78 Z" />
         ]
      end
    end
  },
  traitor: %Q{
    defs do
      group(id: 'badge') do
        raw %Q[
          <path fill="#fff" opacity="1.00" d=" M 13.30 5.14 C 13.82 5.67 14.34 6.19 14.87 6.70 C 14.40 7.14 13.48 8.02 13.01 8.46 C 13.35 9.38 13.70 10.29 14.06 11.19 C 13.18 10.87 12.31 10.52 11.45 10.15 C 9.76 11.79 7.98 13.41 5.73 14.27 C 6.59 12.02 8.21 10.24 9.86 8.54 C 9.48 7.69 9.13 6.84 8.82 5.97 C 9.72 6.31 10.63 6.65 11.54 6.98 C 11.98 6.52 12.86 5.60 13.30 5.14 Z" />
        ]
      end
    end
  },
}
# # Bar
#
# sketchybar --bar color=0x00000000 \
#                  height=56        \
#                  margin=0         \
#                  y_offset=0       \
#                  padding_left=8   \
#                  padding_right=8
#
# # Defaults
#
# sketchybar --default padding_left=8                                \
#                      padding_right=8                               \
#                                                                    \
#                      background.border_color=$YELLOW               \
#                      background.border_width=2                     \
#                      background.height=40                          \
#                      background.corner_radius=12                   \
#                                                                    \
#                      icon.color=$YELLOW                            \
#                      icon.highlight_color=$BACKGROUND              \
#                      icon.padding_left=6                           \
#                      icon.padding_right=2                          \
#                      icon.font="CaskaydiaCove Nerd Font:Book:16.0" \
#                                                                    \
#                      label.color=$YELLOW                           \
#                      label.highlight_color=$BACKGROUND             \
#                      label.padding_left=2                          \
#                      label.padding_right=6                         \
#                      label.font="SF Pro:Semibold:12.0"
#
# Items

sketchybar --add item  ip_address right                              \
           --set       ip_address script="$PLUGIN_DIR/ip_address.sh" \
                                  update_freq=30                     \
                                  padding_left=2                     \
                                  padding_right=8                    \
                                  background.border_width=0          \
                                  background.corner_radius=6         \
                                  background.height=24               \
                                  icon.highlight=on                  \
                                  label.highlight=on                 \
           --subscribe ip_address wifi_change                        \
                                                                     \
           --add item  network.up right                              \
           --set       network.up script="$PLUGIN_DIR/network.sh"    \
                                  update_freq=20                     \
                                  padding_left=2                     \
                                  padding_right=2                    \
                                  background.border_width=0          \
                                  background.height=24               \
                                  icon=⇡                             \
                                  icon.color=$YELLOW                 \
                                  label.color=$YELLOW                \
                                                                     \
           --add item  network.down right                            \
           --set       network.down script="$PLUGIN_DIR/network.sh"  \
                               update_freq=20                        \
                               padding_left=8                        \
                               padding_right=2                       \
                               background.border_width=0             \
                               background.height=24                  \
                               icon=⇣                                \
                               icon.color=$GREEN                     \
                               label.color=$GREEN

# Bracket

sketchybar --add bracket status ip_address network.up network.down   \
           --set         status background.color=$BACKGROUND         \
                                background.border_color=$BLUE

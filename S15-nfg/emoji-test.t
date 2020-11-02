# Test generated from emoji-test.txt Emoji version 13.0
use v6;
use Test;
plan 2839;
## 263A FE0F                                  ; fully-qualified     # ☺️ E0.6 smiling face # emoji-test.txt line #56 Emoji version 13.0
is Uni.new(0x263A, 0xFE0F).Str.chars, 1, "Codes: ⟅0x263A, 0xFE0F⟆ ☺️ E0.6 smiling face";
## 2639 FE0F                                  ; fully-qualified     # ☹️ E0.7 frowning face # emoji-test.txt line #122 Emoji version 13.0
is Uni.new(0x2639, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2639, 0xFE0F⟆ ☹️ E0.7 frowning face";
## 2620 FE0F                                  ; fully-qualified     # ☠️ E1.0 skull and crossbones # emoji-test.txt line #153 Emoji version 13.0
is Uni.new(0x2620, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2620, 0xFE0F⟆ ☠️ E1.0 skull and crossbones";
## 2763 FE0F                                  ; fully-qualified     # ❣️ E1.0 heart exclamation # emoji-test.txt line #193 Emoji version 13.0
is Uni.new(0x2763, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2763, 0xFE0F⟆ ❣️ E1.0 heart exclamation";
## 2764 FE0F                                  ; fully-qualified     # ❤️ E0.6 red heart # emoji-test.txt line #196 Emoji version 13.0
is Uni.new(0x2764, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2764, 0xFE0F⟆ ❤️ E0.6 red heart";
## 1F573 FE0F                                 ; fully-qualified     # 🕳️ E0.7 hole # emoji-test.txt line #212 Emoji version 13.0
is Uni.new(0x1F573, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F573, 0xFE0F⟆ 🕳️ E0.7 hole";
## 1F441 FE0F 200D 1F5E8 FE0F                 ; fully-qualified     # 👁️‍🗨️ E2.0 eye in speech bubble # emoji-test.txt line #216 Emoji version 13.0
is Uni.new(0x1F441, 0xFE0F, 0x200D, 0x1F5E8, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F441, 0xFE0F, 0x200D, 0x1F5E8, 0xFE0F⟆ 👁️‍🗨️ E2.0 eye in speech bubble";
## 1F441 200D 1F5E8 FE0F                      ; unqualified         # 👁‍🗨️ E2.0 eye in speech bubble # emoji-test.txt line #217 Emoji version 13.0
is Uni.new(0x1F441, 0x200D, 0x1F5E8, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F441, 0x200D, 0x1F5E8, 0xFE0F⟆ 👁‍🗨️ E2.0 eye in speech bubble";
## 1F441 FE0F 200D 1F5E8                      ; unqualified         # 👁️‍🗨 E2.0 eye in speech bubble # emoji-test.txt line #218 Emoji version 13.0
is Uni.new(0x1F441, 0xFE0F, 0x200D, 0x1F5E8).Str.chars, 1, "Codes: ⟅0x1F441, 0xFE0F, 0x200D, 0x1F5E8⟆ 👁️‍🗨 E2.0 eye in speech bubble";
## 1F441 200D 1F5E8                           ; unqualified         # 👁‍🗨 E2.0 eye in speech bubble # emoji-test.txt line #219 Emoji version 13.0
is Uni.new(0x1F441, 0x200D, 0x1F5E8).Str.chars, 1, "Codes: ⟅0x1F441, 0x200D, 0x1F5E8⟆ 👁‍🗨 E2.0 eye in speech bubble";
## 1F5E8 FE0F                                 ; fully-qualified     # 🗨️ E2.0 left speech bubble # emoji-test.txt line #220 Emoji version 13.0
is Uni.new(0x1F5E8, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5E8, 0xFE0F⟆ 🗨️ E2.0 left speech bubble";
## 1F5EF FE0F                                 ; fully-qualified     # 🗯️ E0.7 right anger bubble # emoji-test.txt line #222 Emoji version 13.0
is Uni.new(0x1F5EF, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5EF, 0xFE0F⟆ 🗯️ E0.7 right anger bubble";
## 1F44B 1F3FB                                ; fully-qualified     # 👋🏻 E1.0 waving hand: light skin tone # emoji-test.txt line #234 Emoji version 13.0
is Uni.new(0x1F44B, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F44B, 0x1F3FB⟆ 👋🏻 E1.0 waving hand: light skin tone";
## 1F44B 1F3FC                                ; fully-qualified     # 👋🏼 E1.0 waving hand: medium-light skin tone # emoji-test.txt line #235 Emoji version 13.0
is Uni.new(0x1F44B, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F44B, 0x1F3FC⟆ 👋🏼 E1.0 waving hand: medium-light skin tone";
## 1F44B 1F3FD                                ; fully-qualified     # 👋🏽 E1.0 waving hand: medium skin tone # emoji-test.txt line #236 Emoji version 13.0
is Uni.new(0x1F44B, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F44B, 0x1F3FD⟆ 👋🏽 E1.0 waving hand: medium skin tone";
## 1F44B 1F3FE                                ; fully-qualified     # 👋🏾 E1.0 waving hand: medium-dark skin tone # emoji-test.txt line #237 Emoji version 13.0
is Uni.new(0x1F44B, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F44B, 0x1F3FE⟆ 👋🏾 E1.0 waving hand: medium-dark skin tone";
## 1F44B 1F3FF                                ; fully-qualified     # 👋🏿 E1.0 waving hand: dark skin tone # emoji-test.txt line #238 Emoji version 13.0
is Uni.new(0x1F44B, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F44B, 0x1F3FF⟆ 👋🏿 E1.0 waving hand: dark skin tone";
## 1F91A 1F3FB                                ; fully-qualified     # 🤚🏻 E3.0 raised back of hand: light skin tone # emoji-test.txt line #240 Emoji version 13.0
is Uni.new(0x1F91A, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F91A, 0x1F3FB⟆ 🤚🏻 E3.0 raised back of hand: light skin tone";
## 1F91A 1F3FC                                ; fully-qualified     # 🤚🏼 E3.0 raised back of hand: medium-light skin tone # emoji-test.txt line #241 Emoji version 13.0
is Uni.new(0x1F91A, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F91A, 0x1F3FC⟆ 🤚🏼 E3.0 raised back of hand: medium-light skin tone";
## 1F91A 1F3FD                                ; fully-qualified     # 🤚🏽 E3.0 raised back of hand: medium skin tone # emoji-test.txt line #242 Emoji version 13.0
is Uni.new(0x1F91A, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F91A, 0x1F3FD⟆ 🤚🏽 E3.0 raised back of hand: medium skin tone";
## 1F91A 1F3FE                                ; fully-qualified     # 🤚🏾 E3.0 raised back of hand: medium-dark skin tone # emoji-test.txt line #243 Emoji version 13.0
is Uni.new(0x1F91A, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F91A, 0x1F3FE⟆ 🤚🏾 E3.0 raised back of hand: medium-dark skin tone";
## 1F91A 1F3FF                                ; fully-qualified     # 🤚🏿 E3.0 raised back of hand: dark skin tone # emoji-test.txt line #244 Emoji version 13.0
is Uni.new(0x1F91A, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F91A, 0x1F3FF⟆ 🤚🏿 E3.0 raised back of hand: dark skin tone";
## 1F590 FE0F                                 ; fully-qualified     # 🖐️ E0.7 hand with fingers splayed # emoji-test.txt line #245 Emoji version 13.0
is Uni.new(0x1F590, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F590, 0xFE0F⟆ 🖐️ E0.7 hand with fingers splayed";
## 1F590 1F3FB                                ; fully-qualified     # 🖐🏻 E1.0 hand with fingers splayed: light skin tone # emoji-test.txt line #247 Emoji version 13.0
is Uni.new(0x1F590, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F590, 0x1F3FB⟆ 🖐🏻 E1.0 hand with fingers splayed: light skin tone";
## 1F590 1F3FC                                ; fully-qualified     # 🖐🏼 E1.0 hand with fingers splayed: medium-light skin tone # emoji-test.txt line #248 Emoji version 13.0
is Uni.new(0x1F590, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F590, 0x1F3FC⟆ 🖐🏼 E1.0 hand with fingers splayed: medium-light skin tone";
## 1F590 1F3FD                                ; fully-qualified     # 🖐🏽 E1.0 hand with fingers splayed: medium skin tone # emoji-test.txt line #249 Emoji version 13.0
is Uni.new(0x1F590, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F590, 0x1F3FD⟆ 🖐🏽 E1.0 hand with fingers splayed: medium skin tone";
## 1F590 1F3FE                                ; fully-qualified     # 🖐🏾 E1.0 hand with fingers splayed: medium-dark skin tone # emoji-test.txt line #250 Emoji version 13.0
is Uni.new(0x1F590, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F590, 0x1F3FE⟆ 🖐🏾 E1.0 hand with fingers splayed: medium-dark skin tone";
## 1F590 1F3FF                                ; fully-qualified     # 🖐🏿 E1.0 hand with fingers splayed: dark skin tone # emoji-test.txt line #251 Emoji version 13.0
is Uni.new(0x1F590, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F590, 0x1F3FF⟆ 🖐🏿 E1.0 hand with fingers splayed: dark skin tone";
## 270B 1F3FB                                 ; fully-qualified     # ✋🏻 E1.0 raised hand: light skin tone # emoji-test.txt line #253 Emoji version 13.0
is Uni.new(0x270B, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x270B, 0x1F3FB⟆ ✋🏻 E1.0 raised hand: light skin tone";
## 270B 1F3FC                                 ; fully-qualified     # ✋🏼 E1.0 raised hand: medium-light skin tone # emoji-test.txt line #254 Emoji version 13.0
is Uni.new(0x270B, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x270B, 0x1F3FC⟆ ✋🏼 E1.0 raised hand: medium-light skin tone";
## 270B 1F3FD                                 ; fully-qualified     # ✋🏽 E1.0 raised hand: medium skin tone # emoji-test.txt line #255 Emoji version 13.0
is Uni.new(0x270B, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x270B, 0x1F3FD⟆ ✋🏽 E1.0 raised hand: medium skin tone";
## 270B 1F3FE                                 ; fully-qualified     # ✋🏾 E1.0 raised hand: medium-dark skin tone # emoji-test.txt line #256 Emoji version 13.0
is Uni.new(0x270B, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x270B, 0x1F3FE⟆ ✋🏾 E1.0 raised hand: medium-dark skin tone";
## 270B 1F3FF                                 ; fully-qualified     # ✋🏿 E1.0 raised hand: dark skin tone # emoji-test.txt line #257 Emoji version 13.0
is Uni.new(0x270B, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x270B, 0x1F3FF⟆ ✋🏿 E1.0 raised hand: dark skin tone";
## 1F596 1F3FB                                ; fully-qualified     # 🖖🏻 E1.0 vulcan salute: light skin tone # emoji-test.txt line #259 Emoji version 13.0
is Uni.new(0x1F596, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F596, 0x1F3FB⟆ 🖖🏻 E1.0 vulcan salute: light skin tone";
## 1F596 1F3FC                                ; fully-qualified     # 🖖🏼 E1.0 vulcan salute: medium-light skin tone # emoji-test.txt line #260 Emoji version 13.0
is Uni.new(0x1F596, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F596, 0x1F3FC⟆ 🖖🏼 E1.0 vulcan salute: medium-light skin tone";
## 1F596 1F3FD                                ; fully-qualified     # 🖖🏽 E1.0 vulcan salute: medium skin tone # emoji-test.txt line #261 Emoji version 13.0
is Uni.new(0x1F596, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F596, 0x1F3FD⟆ 🖖🏽 E1.0 vulcan salute: medium skin tone";
## 1F596 1F3FE                                ; fully-qualified     # 🖖🏾 E1.0 vulcan salute: medium-dark skin tone # emoji-test.txt line #262 Emoji version 13.0
is Uni.new(0x1F596, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F596, 0x1F3FE⟆ 🖖🏾 E1.0 vulcan salute: medium-dark skin tone";
## 1F596 1F3FF                                ; fully-qualified     # 🖖🏿 E1.0 vulcan salute: dark skin tone # emoji-test.txt line #263 Emoji version 13.0
is Uni.new(0x1F596, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F596, 0x1F3FF⟆ 🖖🏿 E1.0 vulcan salute: dark skin tone";
## 1F44C 1F3FB                                ; fully-qualified     # 👌🏻 E1.0 OK hand: light skin tone # emoji-test.txt line #267 Emoji version 13.0
is Uni.new(0x1F44C, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F44C, 0x1F3FB⟆ 👌🏻 E1.0 OK hand: light skin tone";
## 1F44C 1F3FC                                ; fully-qualified     # 👌🏼 E1.0 OK hand: medium-light skin tone # emoji-test.txt line #268 Emoji version 13.0
is Uni.new(0x1F44C, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F44C, 0x1F3FC⟆ 👌🏼 E1.0 OK hand: medium-light skin tone";
## 1F44C 1F3FD                                ; fully-qualified     # 👌🏽 E1.0 OK hand: medium skin tone # emoji-test.txt line #269 Emoji version 13.0
is Uni.new(0x1F44C, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F44C, 0x1F3FD⟆ 👌🏽 E1.0 OK hand: medium skin tone";
## 1F44C 1F3FE                                ; fully-qualified     # 👌🏾 E1.0 OK hand: medium-dark skin tone # emoji-test.txt line #270 Emoji version 13.0
is Uni.new(0x1F44C, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F44C, 0x1F3FE⟆ 👌🏾 E1.0 OK hand: medium-dark skin tone";
## 1F44C 1F3FF                                ; fully-qualified     # 👌🏿 E1.0 OK hand: dark skin tone # emoji-test.txt line #271 Emoji version 13.0
is Uni.new(0x1F44C, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F44C, 0x1F3FF⟆ 👌🏿 E1.0 OK hand: dark skin tone";
## 1F90C 1F3FB                                ; fully-qualified     # 🤌🏻 E13.0 pinched fingers: light skin tone # emoji-test.txt line #273 Emoji version 13.0
is Uni.new(0x1F90C, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F90C, 0x1F3FB⟆ 🤌🏻 E13.0 pinched fingers: light skin tone";
## 1F90C 1F3FC                                ; fully-qualified     # 🤌🏼 E13.0 pinched fingers: medium-light skin tone # emoji-test.txt line #274 Emoji version 13.0
is Uni.new(0x1F90C, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F90C, 0x1F3FC⟆ 🤌🏼 E13.0 pinched fingers: medium-light skin tone";
## 1F90C 1F3FD                                ; fully-qualified     # 🤌🏽 E13.0 pinched fingers: medium skin tone # emoji-test.txt line #275 Emoji version 13.0
is Uni.new(0x1F90C, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F90C, 0x1F3FD⟆ 🤌🏽 E13.0 pinched fingers: medium skin tone";
## 1F90C 1F3FE                                ; fully-qualified     # 🤌🏾 E13.0 pinched fingers: medium-dark skin tone # emoji-test.txt line #276 Emoji version 13.0
is Uni.new(0x1F90C, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F90C, 0x1F3FE⟆ 🤌🏾 E13.0 pinched fingers: medium-dark skin tone";
## 1F90C 1F3FF                                ; fully-qualified     # 🤌🏿 E13.0 pinched fingers: dark skin tone # emoji-test.txt line #277 Emoji version 13.0
is Uni.new(0x1F90C, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F90C, 0x1F3FF⟆ 🤌🏿 E13.0 pinched fingers: dark skin tone";
## 1F90F 1F3FB                                ; fully-qualified     # 🤏🏻 E12.0 pinching hand: light skin tone # emoji-test.txt line #279 Emoji version 13.0
is Uni.new(0x1F90F, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F90F, 0x1F3FB⟆ 🤏🏻 E12.0 pinching hand: light skin tone";
## 1F90F 1F3FC                                ; fully-qualified     # 🤏🏼 E12.0 pinching hand: medium-light skin tone # emoji-test.txt line #280 Emoji version 13.0
is Uni.new(0x1F90F, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F90F, 0x1F3FC⟆ 🤏🏼 E12.0 pinching hand: medium-light skin tone";
## 1F90F 1F3FD                                ; fully-qualified     # 🤏🏽 E12.0 pinching hand: medium skin tone # emoji-test.txt line #281 Emoji version 13.0
is Uni.new(0x1F90F, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F90F, 0x1F3FD⟆ 🤏🏽 E12.0 pinching hand: medium skin tone";
## 1F90F 1F3FE                                ; fully-qualified     # 🤏🏾 E12.0 pinching hand: medium-dark skin tone # emoji-test.txt line #282 Emoji version 13.0
is Uni.new(0x1F90F, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F90F, 0x1F3FE⟆ 🤏🏾 E12.0 pinching hand: medium-dark skin tone";
## 1F90F 1F3FF                                ; fully-qualified     # 🤏🏿 E12.0 pinching hand: dark skin tone # emoji-test.txt line #283 Emoji version 13.0
is Uni.new(0x1F90F, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F90F, 0x1F3FF⟆ 🤏🏿 E12.0 pinching hand: dark skin tone";
## 270C FE0F                                  ; fully-qualified     # ✌️ E0.6 victory hand # emoji-test.txt line #284 Emoji version 13.0
is Uni.new(0x270C, 0xFE0F).Str.chars, 1, "Codes: ⟅0x270C, 0xFE0F⟆ ✌️ E0.6 victory hand";
## 270C 1F3FB                                 ; fully-qualified     # ✌🏻 E1.0 victory hand: light skin tone # emoji-test.txt line #286 Emoji version 13.0
is Uni.new(0x270C, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x270C, 0x1F3FB⟆ ✌🏻 E1.0 victory hand: light skin tone";
## 270C 1F3FC                                 ; fully-qualified     # ✌🏼 E1.0 victory hand: medium-light skin tone # emoji-test.txt line #287 Emoji version 13.0
is Uni.new(0x270C, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x270C, 0x1F3FC⟆ ✌🏼 E1.0 victory hand: medium-light skin tone";
## 270C 1F3FD                                 ; fully-qualified     # ✌🏽 E1.0 victory hand: medium skin tone # emoji-test.txt line #288 Emoji version 13.0
is Uni.new(0x270C, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x270C, 0x1F3FD⟆ ✌🏽 E1.0 victory hand: medium skin tone";
## 270C 1F3FE                                 ; fully-qualified     # ✌🏾 E1.0 victory hand: medium-dark skin tone # emoji-test.txt line #289 Emoji version 13.0
is Uni.new(0x270C, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x270C, 0x1F3FE⟆ ✌🏾 E1.0 victory hand: medium-dark skin tone";
## 270C 1F3FF                                 ; fully-qualified     # ✌🏿 E1.0 victory hand: dark skin tone # emoji-test.txt line #290 Emoji version 13.0
is Uni.new(0x270C, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x270C, 0x1F3FF⟆ ✌🏿 E1.0 victory hand: dark skin tone";
## 1F91E 1F3FB                                ; fully-qualified     # 🤞🏻 E3.0 crossed fingers: light skin tone # emoji-test.txt line #292 Emoji version 13.0
is Uni.new(0x1F91E, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F91E, 0x1F3FB⟆ 🤞🏻 E3.0 crossed fingers: light skin tone";
## 1F91E 1F3FC                                ; fully-qualified     # 🤞🏼 E3.0 crossed fingers: medium-light skin tone # emoji-test.txt line #293 Emoji version 13.0
is Uni.new(0x1F91E, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F91E, 0x1F3FC⟆ 🤞🏼 E3.0 crossed fingers: medium-light skin tone";
## 1F91E 1F3FD                                ; fully-qualified     # 🤞🏽 E3.0 crossed fingers: medium skin tone # emoji-test.txt line #294 Emoji version 13.0
is Uni.new(0x1F91E, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F91E, 0x1F3FD⟆ 🤞🏽 E3.0 crossed fingers: medium skin tone";
## 1F91E 1F3FE                                ; fully-qualified     # 🤞🏾 E3.0 crossed fingers: medium-dark skin tone # emoji-test.txt line #295 Emoji version 13.0
is Uni.new(0x1F91E, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F91E, 0x1F3FE⟆ 🤞🏾 E3.0 crossed fingers: medium-dark skin tone";
## 1F91E 1F3FF                                ; fully-qualified     # 🤞🏿 E3.0 crossed fingers: dark skin tone # emoji-test.txt line #296 Emoji version 13.0
is Uni.new(0x1F91E, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F91E, 0x1F3FF⟆ 🤞🏿 E3.0 crossed fingers: dark skin tone";
## 1F91F 1F3FB                                ; fully-qualified     # 🤟🏻 E5.0 love-you gesture: light skin tone # emoji-test.txt line #298 Emoji version 13.0
is Uni.new(0x1F91F, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F91F, 0x1F3FB⟆ 🤟🏻 E5.0 love-you gesture: light skin tone";
## 1F91F 1F3FC                                ; fully-qualified     # 🤟🏼 E5.0 love-you gesture: medium-light skin tone # emoji-test.txt line #299 Emoji version 13.0
is Uni.new(0x1F91F, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F91F, 0x1F3FC⟆ 🤟🏼 E5.0 love-you gesture: medium-light skin tone";
## 1F91F 1F3FD                                ; fully-qualified     # 🤟🏽 E5.0 love-you gesture: medium skin tone # emoji-test.txt line #300 Emoji version 13.0
is Uni.new(0x1F91F, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F91F, 0x1F3FD⟆ 🤟🏽 E5.0 love-you gesture: medium skin tone";
## 1F91F 1F3FE                                ; fully-qualified     # 🤟🏾 E5.0 love-you gesture: medium-dark skin tone # emoji-test.txt line #301 Emoji version 13.0
is Uni.new(0x1F91F, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F91F, 0x1F3FE⟆ 🤟🏾 E5.0 love-you gesture: medium-dark skin tone";
## 1F91F 1F3FF                                ; fully-qualified     # 🤟🏿 E5.0 love-you gesture: dark skin tone # emoji-test.txt line #302 Emoji version 13.0
is Uni.new(0x1F91F, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F91F, 0x1F3FF⟆ 🤟🏿 E5.0 love-you gesture: dark skin tone";
## 1F918 1F3FB                                ; fully-qualified     # 🤘🏻 E1.0 sign of the horns: light skin tone # emoji-test.txt line #304 Emoji version 13.0
is Uni.new(0x1F918, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F918, 0x1F3FB⟆ 🤘🏻 E1.0 sign of the horns: light skin tone";
## 1F918 1F3FC                                ; fully-qualified     # 🤘🏼 E1.0 sign of the horns: medium-light skin tone # emoji-test.txt line #305 Emoji version 13.0
is Uni.new(0x1F918, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F918, 0x1F3FC⟆ 🤘🏼 E1.0 sign of the horns: medium-light skin tone";
## 1F918 1F3FD                                ; fully-qualified     # 🤘🏽 E1.0 sign of the horns: medium skin tone # emoji-test.txt line #306 Emoji version 13.0
is Uni.new(0x1F918, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F918, 0x1F3FD⟆ 🤘🏽 E1.0 sign of the horns: medium skin tone";
## 1F918 1F3FE                                ; fully-qualified     # 🤘🏾 E1.0 sign of the horns: medium-dark skin tone # emoji-test.txt line #307 Emoji version 13.0
is Uni.new(0x1F918, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F918, 0x1F3FE⟆ 🤘🏾 E1.0 sign of the horns: medium-dark skin tone";
## 1F918 1F3FF                                ; fully-qualified     # 🤘🏿 E1.0 sign of the horns: dark skin tone # emoji-test.txt line #308 Emoji version 13.0
is Uni.new(0x1F918, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F918, 0x1F3FF⟆ 🤘🏿 E1.0 sign of the horns: dark skin tone";
## 1F919 1F3FB                                ; fully-qualified     # 🤙🏻 E3.0 call me hand: light skin tone # emoji-test.txt line #310 Emoji version 13.0
is Uni.new(0x1F919, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F919, 0x1F3FB⟆ 🤙🏻 E3.0 call me hand: light skin tone";
## 1F919 1F3FC                                ; fully-qualified     # 🤙🏼 E3.0 call me hand: medium-light skin tone # emoji-test.txt line #311 Emoji version 13.0
is Uni.new(0x1F919, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F919, 0x1F3FC⟆ 🤙🏼 E3.0 call me hand: medium-light skin tone";
## 1F919 1F3FD                                ; fully-qualified     # 🤙🏽 E3.0 call me hand: medium skin tone # emoji-test.txt line #312 Emoji version 13.0
is Uni.new(0x1F919, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F919, 0x1F3FD⟆ 🤙🏽 E3.0 call me hand: medium skin tone";
## 1F919 1F3FE                                ; fully-qualified     # 🤙🏾 E3.0 call me hand: medium-dark skin tone # emoji-test.txt line #313 Emoji version 13.0
is Uni.new(0x1F919, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F919, 0x1F3FE⟆ 🤙🏾 E3.0 call me hand: medium-dark skin tone";
## 1F919 1F3FF                                ; fully-qualified     # 🤙🏿 E3.0 call me hand: dark skin tone # emoji-test.txt line #314 Emoji version 13.0
is Uni.new(0x1F919, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F919, 0x1F3FF⟆ 🤙🏿 E3.0 call me hand: dark skin tone";
## 1F448 1F3FB                                ; fully-qualified     # 👈🏻 E1.0 backhand index pointing left: light skin tone # emoji-test.txt line #318 Emoji version 13.0
is Uni.new(0x1F448, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F448, 0x1F3FB⟆ 👈🏻 E1.0 backhand index pointing left: light skin tone";
## 1F448 1F3FC                                ; fully-qualified     # 👈🏼 E1.0 backhand index pointing left: medium-light skin tone # emoji-test.txt line #319 Emoji version 13.0
is Uni.new(0x1F448, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F448, 0x1F3FC⟆ 👈🏼 E1.0 backhand index pointing left: medium-light skin tone";
## 1F448 1F3FD                                ; fully-qualified     # 👈🏽 E1.0 backhand index pointing left: medium skin tone # emoji-test.txt line #320 Emoji version 13.0
is Uni.new(0x1F448, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F448, 0x1F3FD⟆ 👈🏽 E1.0 backhand index pointing left: medium skin tone";
## 1F448 1F3FE                                ; fully-qualified     # 👈🏾 E1.0 backhand index pointing left: medium-dark skin tone # emoji-test.txt line #321 Emoji version 13.0
is Uni.new(0x1F448, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F448, 0x1F3FE⟆ 👈🏾 E1.0 backhand index pointing left: medium-dark skin tone";
## 1F448 1F3FF                                ; fully-qualified     # 👈🏿 E1.0 backhand index pointing left: dark skin tone # emoji-test.txt line #322 Emoji version 13.0
is Uni.new(0x1F448, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F448, 0x1F3FF⟆ 👈🏿 E1.0 backhand index pointing left: dark skin tone";
## 1F449 1F3FB                                ; fully-qualified     # 👉🏻 E1.0 backhand index pointing right: light skin tone # emoji-test.txt line #324 Emoji version 13.0
is Uni.new(0x1F449, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F449, 0x1F3FB⟆ 👉🏻 E1.0 backhand index pointing right: light skin tone";
## 1F449 1F3FC                                ; fully-qualified     # 👉🏼 E1.0 backhand index pointing right: medium-light skin tone # emoji-test.txt line #325 Emoji version 13.0
is Uni.new(0x1F449, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F449, 0x1F3FC⟆ 👉🏼 E1.0 backhand index pointing right: medium-light skin tone";
## 1F449 1F3FD                                ; fully-qualified     # 👉🏽 E1.0 backhand index pointing right: medium skin tone # emoji-test.txt line #326 Emoji version 13.0
is Uni.new(0x1F449, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F449, 0x1F3FD⟆ 👉🏽 E1.0 backhand index pointing right: medium skin tone";
## 1F449 1F3FE                                ; fully-qualified     # 👉🏾 E1.0 backhand index pointing right: medium-dark skin tone # emoji-test.txt line #327 Emoji version 13.0
is Uni.new(0x1F449, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F449, 0x1F3FE⟆ 👉🏾 E1.0 backhand index pointing right: medium-dark skin tone";
## 1F449 1F3FF                                ; fully-qualified     # 👉🏿 E1.0 backhand index pointing right: dark skin tone # emoji-test.txt line #328 Emoji version 13.0
is Uni.new(0x1F449, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F449, 0x1F3FF⟆ 👉🏿 E1.0 backhand index pointing right: dark skin tone";
## 1F446 1F3FB                                ; fully-qualified     # 👆🏻 E1.0 backhand index pointing up: light skin tone # emoji-test.txt line #330 Emoji version 13.0
is Uni.new(0x1F446, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F446, 0x1F3FB⟆ 👆🏻 E1.0 backhand index pointing up: light skin tone";
## 1F446 1F3FC                                ; fully-qualified     # 👆🏼 E1.0 backhand index pointing up: medium-light skin tone # emoji-test.txt line #331 Emoji version 13.0
is Uni.new(0x1F446, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F446, 0x1F3FC⟆ 👆🏼 E1.0 backhand index pointing up: medium-light skin tone";
## 1F446 1F3FD                                ; fully-qualified     # 👆🏽 E1.0 backhand index pointing up: medium skin tone # emoji-test.txt line #332 Emoji version 13.0
is Uni.new(0x1F446, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F446, 0x1F3FD⟆ 👆🏽 E1.0 backhand index pointing up: medium skin tone";
## 1F446 1F3FE                                ; fully-qualified     # 👆🏾 E1.0 backhand index pointing up: medium-dark skin tone # emoji-test.txt line #333 Emoji version 13.0
is Uni.new(0x1F446, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F446, 0x1F3FE⟆ 👆🏾 E1.0 backhand index pointing up: medium-dark skin tone";
## 1F446 1F3FF                                ; fully-qualified     # 👆🏿 E1.0 backhand index pointing up: dark skin tone # emoji-test.txt line #334 Emoji version 13.0
is Uni.new(0x1F446, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F446, 0x1F3FF⟆ 👆🏿 E1.0 backhand index pointing up: dark skin tone";
## 1F595 1F3FB                                ; fully-qualified     # 🖕🏻 E1.0 middle finger: light skin tone # emoji-test.txt line #336 Emoji version 13.0
is Uni.new(0x1F595, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F595, 0x1F3FB⟆ 🖕🏻 E1.0 middle finger: light skin tone";
## 1F595 1F3FC                                ; fully-qualified     # 🖕🏼 E1.0 middle finger: medium-light skin tone # emoji-test.txt line #337 Emoji version 13.0
is Uni.new(0x1F595, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F595, 0x1F3FC⟆ 🖕🏼 E1.0 middle finger: medium-light skin tone";
## 1F595 1F3FD                                ; fully-qualified     # 🖕🏽 E1.0 middle finger: medium skin tone # emoji-test.txt line #338 Emoji version 13.0
is Uni.new(0x1F595, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F595, 0x1F3FD⟆ 🖕🏽 E1.0 middle finger: medium skin tone";
## 1F595 1F3FE                                ; fully-qualified     # 🖕🏾 E1.0 middle finger: medium-dark skin tone # emoji-test.txt line #339 Emoji version 13.0
is Uni.new(0x1F595, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F595, 0x1F3FE⟆ 🖕🏾 E1.0 middle finger: medium-dark skin tone";
## 1F595 1F3FF                                ; fully-qualified     # 🖕🏿 E1.0 middle finger: dark skin tone # emoji-test.txt line #340 Emoji version 13.0
is Uni.new(0x1F595, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F595, 0x1F3FF⟆ 🖕🏿 E1.0 middle finger: dark skin tone";
## 1F447 1F3FB                                ; fully-qualified     # 👇🏻 E1.0 backhand index pointing down: light skin tone # emoji-test.txt line #342 Emoji version 13.0
is Uni.new(0x1F447, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F447, 0x1F3FB⟆ 👇🏻 E1.0 backhand index pointing down: light skin tone";
## 1F447 1F3FC                                ; fully-qualified     # 👇🏼 E1.0 backhand index pointing down: medium-light skin tone # emoji-test.txt line #343 Emoji version 13.0
is Uni.new(0x1F447, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F447, 0x1F3FC⟆ 👇🏼 E1.0 backhand index pointing down: medium-light skin tone";
## 1F447 1F3FD                                ; fully-qualified     # 👇🏽 E1.0 backhand index pointing down: medium skin tone # emoji-test.txt line #344 Emoji version 13.0
is Uni.new(0x1F447, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F447, 0x1F3FD⟆ 👇🏽 E1.0 backhand index pointing down: medium skin tone";
## 1F447 1F3FE                                ; fully-qualified     # 👇🏾 E1.0 backhand index pointing down: medium-dark skin tone # emoji-test.txt line #345 Emoji version 13.0
is Uni.new(0x1F447, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F447, 0x1F3FE⟆ 👇🏾 E1.0 backhand index pointing down: medium-dark skin tone";
## 1F447 1F3FF                                ; fully-qualified     # 👇🏿 E1.0 backhand index pointing down: dark skin tone # emoji-test.txt line #346 Emoji version 13.0
is Uni.new(0x1F447, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F447, 0x1F3FF⟆ 👇🏿 E1.0 backhand index pointing down: dark skin tone";
## 261D FE0F                                  ; fully-qualified     # ☝️ E0.6 index pointing up # emoji-test.txt line #347 Emoji version 13.0
is Uni.new(0x261D, 0xFE0F).Str.chars, 1, "Codes: ⟅0x261D, 0xFE0F⟆ ☝️ E0.6 index pointing up";
## 261D 1F3FB                                 ; fully-qualified     # ☝🏻 E1.0 index pointing up: light skin tone # emoji-test.txt line #349 Emoji version 13.0
is Uni.new(0x261D, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x261D, 0x1F3FB⟆ ☝🏻 E1.0 index pointing up: light skin tone";
## 261D 1F3FC                                 ; fully-qualified     # ☝🏼 E1.0 index pointing up: medium-light skin tone # emoji-test.txt line #350 Emoji version 13.0
is Uni.new(0x261D, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x261D, 0x1F3FC⟆ ☝🏼 E1.0 index pointing up: medium-light skin tone";
## 261D 1F3FD                                 ; fully-qualified     # ☝🏽 E1.0 index pointing up: medium skin tone # emoji-test.txt line #351 Emoji version 13.0
is Uni.new(0x261D, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x261D, 0x1F3FD⟆ ☝🏽 E1.0 index pointing up: medium skin tone";
## 261D 1F3FE                                 ; fully-qualified     # ☝🏾 E1.0 index pointing up: medium-dark skin tone # emoji-test.txt line #352 Emoji version 13.0
is Uni.new(0x261D, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x261D, 0x1F3FE⟆ ☝🏾 E1.0 index pointing up: medium-dark skin tone";
## 261D 1F3FF                                 ; fully-qualified     # ☝🏿 E1.0 index pointing up: dark skin tone # emoji-test.txt line #353 Emoji version 13.0
is Uni.new(0x261D, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x261D, 0x1F3FF⟆ ☝🏿 E1.0 index pointing up: dark skin tone";
## 1F44D 1F3FB                                ; fully-qualified     # 👍🏻 E1.0 thumbs up: light skin tone # emoji-test.txt line #357 Emoji version 13.0
is Uni.new(0x1F44D, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F44D, 0x1F3FB⟆ 👍🏻 E1.0 thumbs up: light skin tone";
## 1F44D 1F3FC                                ; fully-qualified     # 👍🏼 E1.0 thumbs up: medium-light skin tone # emoji-test.txt line #358 Emoji version 13.0
is Uni.new(0x1F44D, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F44D, 0x1F3FC⟆ 👍🏼 E1.0 thumbs up: medium-light skin tone";
## 1F44D 1F3FD                                ; fully-qualified     # 👍🏽 E1.0 thumbs up: medium skin tone # emoji-test.txt line #359 Emoji version 13.0
is Uni.new(0x1F44D, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F44D, 0x1F3FD⟆ 👍🏽 E1.0 thumbs up: medium skin tone";
## 1F44D 1F3FE                                ; fully-qualified     # 👍🏾 E1.0 thumbs up: medium-dark skin tone # emoji-test.txt line #360 Emoji version 13.0
is Uni.new(0x1F44D, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F44D, 0x1F3FE⟆ 👍🏾 E1.0 thumbs up: medium-dark skin tone";
## 1F44D 1F3FF                                ; fully-qualified     # 👍🏿 E1.0 thumbs up: dark skin tone # emoji-test.txt line #361 Emoji version 13.0
is Uni.new(0x1F44D, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F44D, 0x1F3FF⟆ 👍🏿 E1.0 thumbs up: dark skin tone";
## 1F44E 1F3FB                                ; fully-qualified     # 👎🏻 E1.0 thumbs down: light skin tone # emoji-test.txt line #363 Emoji version 13.0
is Uni.new(0x1F44E, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F44E, 0x1F3FB⟆ 👎🏻 E1.0 thumbs down: light skin tone";
## 1F44E 1F3FC                                ; fully-qualified     # 👎🏼 E1.0 thumbs down: medium-light skin tone # emoji-test.txt line #364 Emoji version 13.0
is Uni.new(0x1F44E, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F44E, 0x1F3FC⟆ 👎🏼 E1.0 thumbs down: medium-light skin tone";
## 1F44E 1F3FD                                ; fully-qualified     # 👎🏽 E1.0 thumbs down: medium skin tone # emoji-test.txt line #365 Emoji version 13.0
is Uni.new(0x1F44E, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F44E, 0x1F3FD⟆ 👎🏽 E1.0 thumbs down: medium skin tone";
## 1F44E 1F3FE                                ; fully-qualified     # 👎🏾 E1.0 thumbs down: medium-dark skin tone # emoji-test.txt line #366 Emoji version 13.0
is Uni.new(0x1F44E, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F44E, 0x1F3FE⟆ 👎🏾 E1.0 thumbs down: medium-dark skin tone";
## 1F44E 1F3FF                                ; fully-qualified     # 👎🏿 E1.0 thumbs down: dark skin tone # emoji-test.txt line #367 Emoji version 13.0
is Uni.new(0x1F44E, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F44E, 0x1F3FF⟆ 👎🏿 E1.0 thumbs down: dark skin tone";
## 270A 1F3FB                                 ; fully-qualified     # ✊🏻 E1.0 raised fist: light skin tone # emoji-test.txt line #369 Emoji version 13.0
is Uni.new(0x270A, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x270A, 0x1F3FB⟆ ✊🏻 E1.0 raised fist: light skin tone";
## 270A 1F3FC                                 ; fully-qualified     # ✊🏼 E1.0 raised fist: medium-light skin tone # emoji-test.txt line #370 Emoji version 13.0
is Uni.new(0x270A, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x270A, 0x1F3FC⟆ ✊🏼 E1.0 raised fist: medium-light skin tone";
## 270A 1F3FD                                 ; fully-qualified     # ✊🏽 E1.0 raised fist: medium skin tone # emoji-test.txt line #371 Emoji version 13.0
is Uni.new(0x270A, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x270A, 0x1F3FD⟆ ✊🏽 E1.0 raised fist: medium skin tone";
## 270A 1F3FE                                 ; fully-qualified     # ✊🏾 E1.0 raised fist: medium-dark skin tone # emoji-test.txt line #372 Emoji version 13.0
is Uni.new(0x270A, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x270A, 0x1F3FE⟆ ✊🏾 E1.0 raised fist: medium-dark skin tone";
## 270A 1F3FF                                 ; fully-qualified     # ✊🏿 E1.0 raised fist: dark skin tone # emoji-test.txt line #373 Emoji version 13.0
is Uni.new(0x270A, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x270A, 0x1F3FF⟆ ✊🏿 E1.0 raised fist: dark skin tone";
## 1F44A 1F3FB                                ; fully-qualified     # 👊🏻 E1.0 oncoming fist: light skin tone # emoji-test.txt line #375 Emoji version 13.0
is Uni.new(0x1F44A, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F44A, 0x1F3FB⟆ 👊🏻 E1.0 oncoming fist: light skin tone";
## 1F44A 1F3FC                                ; fully-qualified     # 👊🏼 E1.0 oncoming fist: medium-light skin tone # emoji-test.txt line #376 Emoji version 13.0
is Uni.new(0x1F44A, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F44A, 0x1F3FC⟆ 👊🏼 E1.0 oncoming fist: medium-light skin tone";
## 1F44A 1F3FD                                ; fully-qualified     # 👊🏽 E1.0 oncoming fist: medium skin tone # emoji-test.txt line #377 Emoji version 13.0
is Uni.new(0x1F44A, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F44A, 0x1F3FD⟆ 👊🏽 E1.0 oncoming fist: medium skin tone";
## 1F44A 1F3FE                                ; fully-qualified     # 👊🏾 E1.0 oncoming fist: medium-dark skin tone # emoji-test.txt line #378 Emoji version 13.0
is Uni.new(0x1F44A, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F44A, 0x1F3FE⟆ 👊🏾 E1.0 oncoming fist: medium-dark skin tone";
## 1F44A 1F3FF                                ; fully-qualified     # 👊🏿 E1.0 oncoming fist: dark skin tone # emoji-test.txt line #379 Emoji version 13.0
is Uni.new(0x1F44A, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F44A, 0x1F3FF⟆ 👊🏿 E1.0 oncoming fist: dark skin tone";
## 1F91B 1F3FB                                ; fully-qualified     # 🤛🏻 E3.0 left-facing fist: light skin tone # emoji-test.txt line #381 Emoji version 13.0
is Uni.new(0x1F91B, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F91B, 0x1F3FB⟆ 🤛🏻 E3.0 left-facing fist: light skin tone";
## 1F91B 1F3FC                                ; fully-qualified     # 🤛🏼 E3.0 left-facing fist: medium-light skin tone # emoji-test.txt line #382 Emoji version 13.0
is Uni.new(0x1F91B, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F91B, 0x1F3FC⟆ 🤛🏼 E3.0 left-facing fist: medium-light skin tone";
## 1F91B 1F3FD                                ; fully-qualified     # 🤛🏽 E3.0 left-facing fist: medium skin tone # emoji-test.txt line #383 Emoji version 13.0
is Uni.new(0x1F91B, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F91B, 0x1F3FD⟆ 🤛🏽 E3.0 left-facing fist: medium skin tone";
## 1F91B 1F3FE                                ; fully-qualified     # 🤛🏾 E3.0 left-facing fist: medium-dark skin tone # emoji-test.txt line #384 Emoji version 13.0
is Uni.new(0x1F91B, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F91B, 0x1F3FE⟆ 🤛🏾 E3.0 left-facing fist: medium-dark skin tone";
## 1F91B 1F3FF                                ; fully-qualified     # 🤛🏿 E3.0 left-facing fist: dark skin tone # emoji-test.txt line #385 Emoji version 13.0
is Uni.new(0x1F91B, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F91B, 0x1F3FF⟆ 🤛🏿 E3.0 left-facing fist: dark skin tone";
## 1F91C 1F3FB                                ; fully-qualified     # 🤜🏻 E3.0 right-facing fist: light skin tone # emoji-test.txt line #387 Emoji version 13.0
is Uni.new(0x1F91C, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F91C, 0x1F3FB⟆ 🤜🏻 E3.0 right-facing fist: light skin tone";
## 1F91C 1F3FC                                ; fully-qualified     # 🤜🏼 E3.0 right-facing fist: medium-light skin tone # emoji-test.txt line #388 Emoji version 13.0
is Uni.new(0x1F91C, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F91C, 0x1F3FC⟆ 🤜🏼 E3.0 right-facing fist: medium-light skin tone";
## 1F91C 1F3FD                                ; fully-qualified     # 🤜🏽 E3.0 right-facing fist: medium skin tone # emoji-test.txt line #389 Emoji version 13.0
is Uni.new(0x1F91C, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F91C, 0x1F3FD⟆ 🤜🏽 E3.0 right-facing fist: medium skin tone";
## 1F91C 1F3FE                                ; fully-qualified     # 🤜🏾 E3.0 right-facing fist: medium-dark skin tone # emoji-test.txt line #390 Emoji version 13.0
is Uni.new(0x1F91C, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F91C, 0x1F3FE⟆ 🤜🏾 E3.0 right-facing fist: medium-dark skin tone";
## 1F91C 1F3FF                                ; fully-qualified     # 🤜🏿 E3.0 right-facing fist: dark skin tone # emoji-test.txt line #391 Emoji version 13.0
is Uni.new(0x1F91C, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F91C, 0x1F3FF⟆ 🤜🏿 E3.0 right-facing fist: dark skin tone";
## 1F44F 1F3FB                                ; fully-qualified     # 👏🏻 E1.0 clapping hands: light skin tone # emoji-test.txt line #395 Emoji version 13.0
is Uni.new(0x1F44F, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F44F, 0x1F3FB⟆ 👏🏻 E1.0 clapping hands: light skin tone";
## 1F44F 1F3FC                                ; fully-qualified     # 👏🏼 E1.0 clapping hands: medium-light skin tone # emoji-test.txt line #396 Emoji version 13.0
is Uni.new(0x1F44F, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F44F, 0x1F3FC⟆ 👏🏼 E1.0 clapping hands: medium-light skin tone";
## 1F44F 1F3FD                                ; fully-qualified     # 👏🏽 E1.0 clapping hands: medium skin tone # emoji-test.txt line #397 Emoji version 13.0
is Uni.new(0x1F44F, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F44F, 0x1F3FD⟆ 👏🏽 E1.0 clapping hands: medium skin tone";
## 1F44F 1F3FE                                ; fully-qualified     # 👏🏾 E1.0 clapping hands: medium-dark skin tone # emoji-test.txt line #398 Emoji version 13.0
is Uni.new(0x1F44F, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F44F, 0x1F3FE⟆ 👏🏾 E1.0 clapping hands: medium-dark skin tone";
## 1F44F 1F3FF                                ; fully-qualified     # 👏🏿 E1.0 clapping hands: dark skin tone # emoji-test.txt line #399 Emoji version 13.0
is Uni.new(0x1F44F, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F44F, 0x1F3FF⟆ 👏🏿 E1.0 clapping hands: dark skin tone";
## 1F64C 1F3FB                                ; fully-qualified     # 🙌🏻 E1.0 raising hands: light skin tone # emoji-test.txt line #401 Emoji version 13.0
is Uni.new(0x1F64C, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F64C, 0x1F3FB⟆ 🙌🏻 E1.0 raising hands: light skin tone";
## 1F64C 1F3FC                                ; fully-qualified     # 🙌🏼 E1.0 raising hands: medium-light skin tone # emoji-test.txt line #402 Emoji version 13.0
is Uni.new(0x1F64C, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F64C, 0x1F3FC⟆ 🙌🏼 E1.0 raising hands: medium-light skin tone";
## 1F64C 1F3FD                                ; fully-qualified     # 🙌🏽 E1.0 raising hands: medium skin tone # emoji-test.txt line #403 Emoji version 13.0
is Uni.new(0x1F64C, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F64C, 0x1F3FD⟆ 🙌🏽 E1.0 raising hands: medium skin tone";
## 1F64C 1F3FE                                ; fully-qualified     # 🙌🏾 E1.0 raising hands: medium-dark skin tone # emoji-test.txt line #404 Emoji version 13.0
is Uni.new(0x1F64C, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F64C, 0x1F3FE⟆ 🙌🏾 E1.0 raising hands: medium-dark skin tone";
## 1F64C 1F3FF                                ; fully-qualified     # 🙌🏿 E1.0 raising hands: dark skin tone # emoji-test.txt line #405 Emoji version 13.0
is Uni.new(0x1F64C, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F64C, 0x1F3FF⟆ 🙌🏿 E1.0 raising hands: dark skin tone";
## 1F450 1F3FB                                ; fully-qualified     # 👐🏻 E1.0 open hands: light skin tone # emoji-test.txt line #407 Emoji version 13.0
is Uni.new(0x1F450, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F450, 0x1F3FB⟆ 👐🏻 E1.0 open hands: light skin tone";
## 1F450 1F3FC                                ; fully-qualified     # 👐🏼 E1.0 open hands: medium-light skin tone # emoji-test.txt line #408 Emoji version 13.0
is Uni.new(0x1F450, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F450, 0x1F3FC⟆ 👐🏼 E1.0 open hands: medium-light skin tone";
## 1F450 1F3FD                                ; fully-qualified     # 👐🏽 E1.0 open hands: medium skin tone # emoji-test.txt line #409 Emoji version 13.0
is Uni.new(0x1F450, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F450, 0x1F3FD⟆ 👐🏽 E1.0 open hands: medium skin tone";
## 1F450 1F3FE                                ; fully-qualified     # 👐🏾 E1.0 open hands: medium-dark skin tone # emoji-test.txt line #410 Emoji version 13.0
is Uni.new(0x1F450, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F450, 0x1F3FE⟆ 👐🏾 E1.0 open hands: medium-dark skin tone";
## 1F450 1F3FF                                ; fully-qualified     # 👐🏿 E1.0 open hands: dark skin tone # emoji-test.txt line #411 Emoji version 13.0
is Uni.new(0x1F450, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F450, 0x1F3FF⟆ 👐🏿 E1.0 open hands: dark skin tone";
## 1F932 1F3FB                                ; fully-qualified     # 🤲🏻 E5.0 palms up together: light skin tone # emoji-test.txt line #413 Emoji version 13.0
is Uni.new(0x1F932, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F932, 0x1F3FB⟆ 🤲🏻 E5.0 palms up together: light skin tone";
## 1F932 1F3FC                                ; fully-qualified     # 🤲🏼 E5.0 palms up together: medium-light skin tone # emoji-test.txt line #414 Emoji version 13.0
is Uni.new(0x1F932, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F932, 0x1F3FC⟆ 🤲🏼 E5.0 palms up together: medium-light skin tone";
## 1F932 1F3FD                                ; fully-qualified     # 🤲🏽 E5.0 palms up together: medium skin tone # emoji-test.txt line #415 Emoji version 13.0
is Uni.new(0x1F932, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F932, 0x1F3FD⟆ 🤲🏽 E5.0 palms up together: medium skin tone";
## 1F932 1F3FE                                ; fully-qualified     # 🤲🏾 E5.0 palms up together: medium-dark skin tone # emoji-test.txt line #416 Emoji version 13.0
is Uni.new(0x1F932, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F932, 0x1F3FE⟆ 🤲🏾 E5.0 palms up together: medium-dark skin tone";
## 1F932 1F3FF                                ; fully-qualified     # 🤲🏿 E5.0 palms up together: dark skin tone # emoji-test.txt line #417 Emoji version 13.0
is Uni.new(0x1F932, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F932, 0x1F3FF⟆ 🤲🏿 E5.0 palms up together: dark skin tone";
## 1F64F 1F3FB                                ; fully-qualified     # 🙏🏻 E1.0 folded hands: light skin tone # emoji-test.txt line #420 Emoji version 13.0
is Uni.new(0x1F64F, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F64F, 0x1F3FB⟆ 🙏🏻 E1.0 folded hands: light skin tone";
## 1F64F 1F3FC                                ; fully-qualified     # 🙏🏼 E1.0 folded hands: medium-light skin tone # emoji-test.txt line #421 Emoji version 13.0
is Uni.new(0x1F64F, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F64F, 0x1F3FC⟆ 🙏🏼 E1.0 folded hands: medium-light skin tone";
## 1F64F 1F3FD                                ; fully-qualified     # 🙏🏽 E1.0 folded hands: medium skin tone # emoji-test.txt line #422 Emoji version 13.0
is Uni.new(0x1F64F, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F64F, 0x1F3FD⟆ 🙏🏽 E1.0 folded hands: medium skin tone";
## 1F64F 1F3FE                                ; fully-qualified     # 🙏🏾 E1.0 folded hands: medium-dark skin tone # emoji-test.txt line #423 Emoji version 13.0
is Uni.new(0x1F64F, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F64F, 0x1F3FE⟆ 🙏🏾 E1.0 folded hands: medium-dark skin tone";
## 1F64F 1F3FF                                ; fully-qualified     # 🙏🏿 E1.0 folded hands: dark skin tone # emoji-test.txt line #424 Emoji version 13.0
is Uni.new(0x1F64F, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F64F, 0x1F3FF⟆ 🙏🏿 E1.0 folded hands: dark skin tone";
## 270D FE0F                                  ; fully-qualified     # ✍️ E0.7 writing hand # emoji-test.txt line #427 Emoji version 13.0
is Uni.new(0x270D, 0xFE0F).Str.chars, 1, "Codes: ⟅0x270D, 0xFE0F⟆ ✍️ E0.7 writing hand";
## 270D 1F3FB                                 ; fully-qualified     # ✍🏻 E1.0 writing hand: light skin tone # emoji-test.txt line #429 Emoji version 13.0
is Uni.new(0x270D, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x270D, 0x1F3FB⟆ ✍🏻 E1.0 writing hand: light skin tone";
## 270D 1F3FC                                 ; fully-qualified     # ✍🏼 E1.0 writing hand: medium-light skin tone # emoji-test.txt line #430 Emoji version 13.0
is Uni.new(0x270D, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x270D, 0x1F3FC⟆ ✍🏼 E1.0 writing hand: medium-light skin tone";
## 270D 1F3FD                                 ; fully-qualified     # ✍🏽 E1.0 writing hand: medium skin tone # emoji-test.txt line #431 Emoji version 13.0
is Uni.new(0x270D, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x270D, 0x1F3FD⟆ ✍🏽 E1.0 writing hand: medium skin tone";
## 270D 1F3FE                                 ; fully-qualified     # ✍🏾 E1.0 writing hand: medium-dark skin tone # emoji-test.txt line #432 Emoji version 13.0
is Uni.new(0x270D, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x270D, 0x1F3FE⟆ ✍🏾 E1.0 writing hand: medium-dark skin tone";
## 270D 1F3FF                                 ; fully-qualified     # ✍🏿 E1.0 writing hand: dark skin tone # emoji-test.txt line #433 Emoji version 13.0
is Uni.new(0x270D, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x270D, 0x1F3FF⟆ ✍🏿 E1.0 writing hand: dark skin tone";
## 1F485 1F3FB                                ; fully-qualified     # 💅🏻 E1.0 nail polish: light skin tone # emoji-test.txt line #435 Emoji version 13.0
is Uni.new(0x1F485, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F485, 0x1F3FB⟆ 💅🏻 E1.0 nail polish: light skin tone";
## 1F485 1F3FC                                ; fully-qualified     # 💅🏼 E1.0 nail polish: medium-light skin tone # emoji-test.txt line #436 Emoji version 13.0
is Uni.new(0x1F485, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F485, 0x1F3FC⟆ 💅🏼 E1.0 nail polish: medium-light skin tone";
## 1F485 1F3FD                                ; fully-qualified     # 💅🏽 E1.0 nail polish: medium skin tone # emoji-test.txt line #437 Emoji version 13.0
is Uni.new(0x1F485, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F485, 0x1F3FD⟆ 💅🏽 E1.0 nail polish: medium skin tone";
## 1F485 1F3FE                                ; fully-qualified     # 💅🏾 E1.0 nail polish: medium-dark skin tone # emoji-test.txt line #438 Emoji version 13.0
is Uni.new(0x1F485, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F485, 0x1F3FE⟆ 💅🏾 E1.0 nail polish: medium-dark skin tone";
## 1F485 1F3FF                                ; fully-qualified     # 💅🏿 E1.0 nail polish: dark skin tone # emoji-test.txt line #439 Emoji version 13.0
is Uni.new(0x1F485, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F485, 0x1F3FF⟆ 💅🏿 E1.0 nail polish: dark skin tone";
## 1F933 1F3FB                                ; fully-qualified     # 🤳🏻 E3.0 selfie: light skin tone # emoji-test.txt line #441 Emoji version 13.0
is Uni.new(0x1F933, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F933, 0x1F3FB⟆ 🤳🏻 E3.0 selfie: light skin tone";
## 1F933 1F3FC                                ; fully-qualified     # 🤳🏼 E3.0 selfie: medium-light skin tone # emoji-test.txt line #442 Emoji version 13.0
is Uni.new(0x1F933, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F933, 0x1F3FC⟆ 🤳🏼 E3.0 selfie: medium-light skin tone";
## 1F933 1F3FD                                ; fully-qualified     # 🤳🏽 E3.0 selfie: medium skin tone # emoji-test.txt line #443 Emoji version 13.0
is Uni.new(0x1F933, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F933, 0x1F3FD⟆ 🤳🏽 E3.0 selfie: medium skin tone";
## 1F933 1F3FE                                ; fully-qualified     # 🤳🏾 E3.0 selfie: medium-dark skin tone # emoji-test.txt line #444 Emoji version 13.0
is Uni.new(0x1F933, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F933, 0x1F3FE⟆ 🤳🏾 E3.0 selfie: medium-dark skin tone";
## 1F933 1F3FF                                ; fully-qualified     # 🤳🏿 E3.0 selfie: dark skin tone # emoji-test.txt line #445 Emoji version 13.0
is Uni.new(0x1F933, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F933, 0x1F3FF⟆ 🤳🏿 E3.0 selfie: dark skin tone";
## 1F4AA 1F3FB                                ; fully-qualified     # 💪🏻 E1.0 flexed biceps: light skin tone # emoji-test.txt line #449 Emoji version 13.0
is Uni.new(0x1F4AA, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F4AA, 0x1F3FB⟆ 💪🏻 E1.0 flexed biceps: light skin tone";
## 1F4AA 1F3FC                                ; fully-qualified     # 💪🏼 E1.0 flexed biceps: medium-light skin tone # emoji-test.txt line #450 Emoji version 13.0
is Uni.new(0x1F4AA, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F4AA, 0x1F3FC⟆ 💪🏼 E1.0 flexed biceps: medium-light skin tone";
## 1F4AA 1F3FD                                ; fully-qualified     # 💪🏽 E1.0 flexed biceps: medium skin tone # emoji-test.txt line #451 Emoji version 13.0
is Uni.new(0x1F4AA, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F4AA, 0x1F3FD⟆ 💪🏽 E1.0 flexed biceps: medium skin tone";
## 1F4AA 1F3FE                                ; fully-qualified     # 💪🏾 E1.0 flexed biceps: medium-dark skin tone # emoji-test.txt line #452 Emoji version 13.0
is Uni.new(0x1F4AA, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F4AA, 0x1F3FE⟆ 💪🏾 E1.0 flexed biceps: medium-dark skin tone";
## 1F4AA 1F3FF                                ; fully-qualified     # 💪🏿 E1.0 flexed biceps: dark skin tone # emoji-test.txt line #453 Emoji version 13.0
is Uni.new(0x1F4AA, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F4AA, 0x1F3FF⟆ 💪🏿 E1.0 flexed biceps: dark skin tone";
## 1F9B5 1F3FB                                ; fully-qualified     # 🦵🏻 E11.0 leg: light skin tone # emoji-test.txt line #457 Emoji version 13.0
is Uni.new(0x1F9B5, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9B5, 0x1F3FB⟆ 🦵🏻 E11.0 leg: light skin tone";
## 1F9B5 1F3FC                                ; fully-qualified     # 🦵🏼 E11.0 leg: medium-light skin tone # emoji-test.txt line #458 Emoji version 13.0
is Uni.new(0x1F9B5, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9B5, 0x1F3FC⟆ 🦵🏼 E11.0 leg: medium-light skin tone";
## 1F9B5 1F3FD                                ; fully-qualified     # 🦵🏽 E11.0 leg: medium skin tone # emoji-test.txt line #459 Emoji version 13.0
is Uni.new(0x1F9B5, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9B5, 0x1F3FD⟆ 🦵🏽 E11.0 leg: medium skin tone";
## 1F9B5 1F3FE                                ; fully-qualified     # 🦵🏾 E11.0 leg: medium-dark skin tone # emoji-test.txt line #460 Emoji version 13.0
is Uni.new(0x1F9B5, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9B5, 0x1F3FE⟆ 🦵🏾 E11.0 leg: medium-dark skin tone";
## 1F9B5 1F3FF                                ; fully-qualified     # 🦵🏿 E11.0 leg: dark skin tone # emoji-test.txt line #461 Emoji version 13.0
is Uni.new(0x1F9B5, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9B5, 0x1F3FF⟆ 🦵🏿 E11.0 leg: dark skin tone";
## 1F9B6 1F3FB                                ; fully-qualified     # 🦶🏻 E11.0 foot: light skin tone # emoji-test.txt line #463 Emoji version 13.0
is Uni.new(0x1F9B6, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9B6, 0x1F3FB⟆ 🦶🏻 E11.0 foot: light skin tone";
## 1F9B6 1F3FC                                ; fully-qualified     # 🦶🏼 E11.0 foot: medium-light skin tone # emoji-test.txt line #464 Emoji version 13.0
is Uni.new(0x1F9B6, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9B6, 0x1F3FC⟆ 🦶🏼 E11.0 foot: medium-light skin tone";
## 1F9B6 1F3FD                                ; fully-qualified     # 🦶🏽 E11.0 foot: medium skin tone # emoji-test.txt line #465 Emoji version 13.0
is Uni.new(0x1F9B6, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9B6, 0x1F3FD⟆ 🦶🏽 E11.0 foot: medium skin tone";
## 1F9B6 1F3FE                                ; fully-qualified     # 🦶🏾 E11.0 foot: medium-dark skin tone # emoji-test.txt line #466 Emoji version 13.0
is Uni.new(0x1F9B6, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9B6, 0x1F3FE⟆ 🦶🏾 E11.0 foot: medium-dark skin tone";
## 1F9B6 1F3FF                                ; fully-qualified     # 🦶🏿 E11.0 foot: dark skin tone # emoji-test.txt line #467 Emoji version 13.0
is Uni.new(0x1F9B6, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9B6, 0x1F3FF⟆ 🦶🏿 E11.0 foot: dark skin tone";
## 1F442 1F3FB                                ; fully-qualified     # 👂🏻 E1.0 ear: light skin tone # emoji-test.txt line #469 Emoji version 13.0
is Uni.new(0x1F442, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F442, 0x1F3FB⟆ 👂🏻 E1.0 ear: light skin tone";
## 1F442 1F3FC                                ; fully-qualified     # 👂🏼 E1.0 ear: medium-light skin tone # emoji-test.txt line #470 Emoji version 13.0
is Uni.new(0x1F442, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F442, 0x1F3FC⟆ 👂🏼 E1.0 ear: medium-light skin tone";
## 1F442 1F3FD                                ; fully-qualified     # 👂🏽 E1.0 ear: medium skin tone # emoji-test.txt line #471 Emoji version 13.0
is Uni.new(0x1F442, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F442, 0x1F3FD⟆ 👂🏽 E1.0 ear: medium skin tone";
## 1F442 1F3FE                                ; fully-qualified     # 👂🏾 E1.0 ear: medium-dark skin tone # emoji-test.txt line #472 Emoji version 13.0
is Uni.new(0x1F442, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F442, 0x1F3FE⟆ 👂🏾 E1.0 ear: medium-dark skin tone";
## 1F442 1F3FF                                ; fully-qualified     # 👂🏿 E1.0 ear: dark skin tone # emoji-test.txt line #473 Emoji version 13.0
is Uni.new(0x1F442, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F442, 0x1F3FF⟆ 👂🏿 E1.0 ear: dark skin tone";
## 1F9BB 1F3FB                                ; fully-qualified     # 🦻🏻 E12.0 ear with hearing aid: light skin tone # emoji-test.txt line #475 Emoji version 13.0
is Uni.new(0x1F9BB, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9BB, 0x1F3FB⟆ 🦻🏻 E12.0 ear with hearing aid: light skin tone";
## 1F9BB 1F3FC                                ; fully-qualified     # 🦻🏼 E12.0 ear with hearing aid: medium-light skin tone # emoji-test.txt line #476 Emoji version 13.0
is Uni.new(0x1F9BB, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9BB, 0x1F3FC⟆ 🦻🏼 E12.0 ear with hearing aid: medium-light skin tone";
## 1F9BB 1F3FD                                ; fully-qualified     # 🦻🏽 E12.0 ear with hearing aid: medium skin tone # emoji-test.txt line #477 Emoji version 13.0
is Uni.new(0x1F9BB, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9BB, 0x1F3FD⟆ 🦻🏽 E12.0 ear with hearing aid: medium skin tone";
## 1F9BB 1F3FE                                ; fully-qualified     # 🦻🏾 E12.0 ear with hearing aid: medium-dark skin tone # emoji-test.txt line #478 Emoji version 13.0
is Uni.new(0x1F9BB, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9BB, 0x1F3FE⟆ 🦻🏾 E12.0 ear with hearing aid: medium-dark skin tone";
## 1F9BB 1F3FF                                ; fully-qualified     # 🦻🏿 E12.0 ear with hearing aid: dark skin tone # emoji-test.txt line #479 Emoji version 13.0
is Uni.new(0x1F9BB, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9BB, 0x1F3FF⟆ 🦻🏿 E12.0 ear with hearing aid: dark skin tone";
## 1F443 1F3FB                                ; fully-qualified     # 👃🏻 E1.0 nose: light skin tone # emoji-test.txt line #481 Emoji version 13.0
is Uni.new(0x1F443, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F443, 0x1F3FB⟆ 👃🏻 E1.0 nose: light skin tone";
## 1F443 1F3FC                                ; fully-qualified     # 👃🏼 E1.0 nose: medium-light skin tone # emoji-test.txt line #482 Emoji version 13.0
is Uni.new(0x1F443, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F443, 0x1F3FC⟆ 👃🏼 E1.0 nose: medium-light skin tone";
## 1F443 1F3FD                                ; fully-qualified     # 👃🏽 E1.0 nose: medium skin tone # emoji-test.txt line #483 Emoji version 13.0
is Uni.new(0x1F443, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F443, 0x1F3FD⟆ 👃🏽 E1.0 nose: medium skin tone";
## 1F443 1F3FE                                ; fully-qualified     # 👃🏾 E1.0 nose: medium-dark skin tone # emoji-test.txt line #484 Emoji version 13.0
is Uni.new(0x1F443, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F443, 0x1F3FE⟆ 👃🏾 E1.0 nose: medium-dark skin tone";
## 1F443 1F3FF                                ; fully-qualified     # 👃🏿 E1.0 nose: dark skin tone # emoji-test.txt line #485 Emoji version 13.0
is Uni.new(0x1F443, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F443, 0x1F3FF⟆ 👃🏿 E1.0 nose: dark skin tone";
## 1F441 FE0F                                 ; fully-qualified     # 👁️ E0.7 eye # emoji-test.txt line #492 Emoji version 13.0
is Uni.new(0x1F441, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F441, 0xFE0F⟆ 👁️ E0.7 eye";
## 1F476 1F3FB                                ; fully-qualified     # 👶🏻 E1.0 baby: light skin tone # emoji-test.txt line #499 Emoji version 13.0
is Uni.new(0x1F476, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F476, 0x1F3FB⟆ 👶🏻 E1.0 baby: light skin tone";
## 1F476 1F3FC                                ; fully-qualified     # 👶🏼 E1.0 baby: medium-light skin tone # emoji-test.txt line #500 Emoji version 13.0
is Uni.new(0x1F476, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F476, 0x1F3FC⟆ 👶🏼 E1.0 baby: medium-light skin tone";
## 1F476 1F3FD                                ; fully-qualified     # 👶🏽 E1.0 baby: medium skin tone # emoji-test.txt line #501 Emoji version 13.0
is Uni.new(0x1F476, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F476, 0x1F3FD⟆ 👶🏽 E1.0 baby: medium skin tone";
## 1F476 1F3FE                                ; fully-qualified     # 👶🏾 E1.0 baby: medium-dark skin tone # emoji-test.txt line #502 Emoji version 13.0
is Uni.new(0x1F476, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F476, 0x1F3FE⟆ 👶🏾 E1.0 baby: medium-dark skin tone";
## 1F476 1F3FF                                ; fully-qualified     # 👶🏿 E1.0 baby: dark skin tone # emoji-test.txt line #503 Emoji version 13.0
is Uni.new(0x1F476, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F476, 0x1F3FF⟆ 👶🏿 E1.0 baby: dark skin tone";
## 1F9D2 1F3FB                                ; fully-qualified     # 🧒🏻 E5.0 child: light skin tone # emoji-test.txt line #505 Emoji version 13.0
is Uni.new(0x1F9D2, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D2, 0x1F3FB⟆ 🧒🏻 E5.0 child: light skin tone";
## 1F9D2 1F3FC                                ; fully-qualified     # 🧒🏼 E5.0 child: medium-light skin tone # emoji-test.txt line #506 Emoji version 13.0
is Uni.new(0x1F9D2, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D2, 0x1F3FC⟆ 🧒🏼 E5.0 child: medium-light skin tone";
## 1F9D2 1F3FD                                ; fully-qualified     # 🧒🏽 E5.0 child: medium skin tone # emoji-test.txt line #507 Emoji version 13.0
is Uni.new(0x1F9D2, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D2, 0x1F3FD⟆ 🧒🏽 E5.0 child: medium skin tone";
## 1F9D2 1F3FE                                ; fully-qualified     # 🧒🏾 E5.0 child: medium-dark skin tone # emoji-test.txt line #508 Emoji version 13.0
is Uni.new(0x1F9D2, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D2, 0x1F3FE⟆ 🧒🏾 E5.0 child: medium-dark skin tone";
## 1F9D2 1F3FF                                ; fully-qualified     # 🧒🏿 E5.0 child: dark skin tone # emoji-test.txt line #509 Emoji version 13.0
is Uni.new(0x1F9D2, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D2, 0x1F3FF⟆ 🧒🏿 E5.0 child: dark skin tone";
## 1F466 1F3FB                                ; fully-qualified     # 👦🏻 E1.0 boy: light skin tone # emoji-test.txt line #511 Emoji version 13.0
is Uni.new(0x1F466, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F466, 0x1F3FB⟆ 👦🏻 E1.0 boy: light skin tone";
## 1F466 1F3FC                                ; fully-qualified     # 👦🏼 E1.0 boy: medium-light skin tone # emoji-test.txt line #512 Emoji version 13.0
is Uni.new(0x1F466, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F466, 0x1F3FC⟆ 👦🏼 E1.0 boy: medium-light skin tone";
## 1F466 1F3FD                                ; fully-qualified     # 👦🏽 E1.0 boy: medium skin tone # emoji-test.txt line #513 Emoji version 13.0
is Uni.new(0x1F466, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F466, 0x1F3FD⟆ 👦🏽 E1.0 boy: medium skin tone";
## 1F466 1F3FE                                ; fully-qualified     # 👦🏾 E1.0 boy: medium-dark skin tone # emoji-test.txt line #514 Emoji version 13.0
is Uni.new(0x1F466, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F466, 0x1F3FE⟆ 👦🏾 E1.0 boy: medium-dark skin tone";
## 1F466 1F3FF                                ; fully-qualified     # 👦🏿 E1.0 boy: dark skin tone # emoji-test.txt line #515 Emoji version 13.0
is Uni.new(0x1F466, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F466, 0x1F3FF⟆ 👦🏿 E1.0 boy: dark skin tone";
## 1F467 1F3FB                                ; fully-qualified     # 👧🏻 E1.0 girl: light skin tone # emoji-test.txt line #517 Emoji version 13.0
is Uni.new(0x1F467, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F467, 0x1F3FB⟆ 👧🏻 E1.0 girl: light skin tone";
## 1F467 1F3FC                                ; fully-qualified     # 👧🏼 E1.0 girl: medium-light skin tone # emoji-test.txt line #518 Emoji version 13.0
is Uni.new(0x1F467, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F467, 0x1F3FC⟆ 👧🏼 E1.0 girl: medium-light skin tone";
## 1F467 1F3FD                                ; fully-qualified     # 👧🏽 E1.0 girl: medium skin tone # emoji-test.txt line #519 Emoji version 13.0
is Uni.new(0x1F467, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F467, 0x1F3FD⟆ 👧🏽 E1.0 girl: medium skin tone";
## 1F467 1F3FE                                ; fully-qualified     # 👧🏾 E1.0 girl: medium-dark skin tone # emoji-test.txt line #520 Emoji version 13.0
is Uni.new(0x1F467, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F467, 0x1F3FE⟆ 👧🏾 E1.0 girl: medium-dark skin tone";
## 1F467 1F3FF                                ; fully-qualified     # 👧🏿 E1.0 girl: dark skin tone # emoji-test.txt line #521 Emoji version 13.0
is Uni.new(0x1F467, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F467, 0x1F3FF⟆ 👧🏿 E1.0 girl: dark skin tone";
## 1F9D1 1F3FB                                ; fully-qualified     # 🧑🏻 E5.0 person: light skin tone # emoji-test.txt line #523 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB⟆ 🧑🏻 E5.0 person: light skin tone";
## 1F9D1 1F3FC                                ; fully-qualified     # 🧑🏼 E5.0 person: medium-light skin tone # emoji-test.txt line #524 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC⟆ 🧑🏼 E5.0 person: medium-light skin tone";
## 1F9D1 1F3FD                                ; fully-qualified     # 🧑🏽 E5.0 person: medium skin tone # emoji-test.txt line #525 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD⟆ 🧑🏽 E5.0 person: medium skin tone";
## 1F9D1 1F3FE                                ; fully-qualified     # 🧑🏾 E5.0 person: medium-dark skin tone # emoji-test.txt line #526 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE⟆ 🧑🏾 E5.0 person: medium-dark skin tone";
## 1F9D1 1F3FF                                ; fully-qualified     # 🧑🏿 E5.0 person: dark skin tone # emoji-test.txt line #527 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF⟆ 🧑🏿 E5.0 person: dark skin tone";
## 1F471 1F3FB                                ; fully-qualified     # 👱🏻 E1.0 person: light skin tone, blond hair # emoji-test.txt line #529 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FB⟆ 👱🏻 E1.0 person: light skin tone, blond hair";
## 1F471 1F3FC                                ; fully-qualified     # 👱🏼 E1.0 person: medium-light skin tone, blond hair # emoji-test.txt line #530 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FC⟆ 👱🏼 E1.0 person: medium-light skin tone, blond hair";
## 1F471 1F3FD                                ; fully-qualified     # 👱🏽 E1.0 person: medium skin tone, blond hair # emoji-test.txt line #531 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FD⟆ 👱🏽 E1.0 person: medium skin tone, blond hair";
## 1F471 1F3FE                                ; fully-qualified     # 👱🏾 E1.0 person: medium-dark skin tone, blond hair # emoji-test.txt line #532 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FE⟆ 👱🏾 E1.0 person: medium-dark skin tone, blond hair";
## 1F471 1F3FF                                ; fully-qualified     # 👱🏿 E1.0 person: dark skin tone, blond hair # emoji-test.txt line #533 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FF⟆ 👱🏿 E1.0 person: dark skin tone, blond hair";
## 1F468 1F3FB                                ; fully-qualified     # 👨🏻 E1.0 man: light skin tone # emoji-test.txt line #535 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB⟆ 👨🏻 E1.0 man: light skin tone";
## 1F468 1F3FC                                ; fully-qualified     # 👨🏼 E1.0 man: medium-light skin tone # emoji-test.txt line #536 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC⟆ 👨🏼 E1.0 man: medium-light skin tone";
## 1F468 1F3FD                                ; fully-qualified     # 👨🏽 E1.0 man: medium skin tone # emoji-test.txt line #537 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD⟆ 👨🏽 E1.0 man: medium skin tone";
## 1F468 1F3FE                                ; fully-qualified     # 👨🏾 E1.0 man: medium-dark skin tone # emoji-test.txt line #538 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE⟆ 👨🏾 E1.0 man: medium-dark skin tone";
## 1F468 1F3FF                                ; fully-qualified     # 👨🏿 E1.0 man: dark skin tone # emoji-test.txt line #539 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF⟆ 👨🏿 E1.0 man: dark skin tone";
## 1F9D4 1F3FB                                ; fully-qualified     # 🧔🏻 E5.0 man: light skin tone, beard # emoji-test.txt line #541 Emoji version 13.0
is Uni.new(0x1F9D4, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D4, 0x1F3FB⟆ 🧔🏻 E5.0 man: light skin tone, beard";
## 1F9D4 1F3FC                                ; fully-qualified     # 🧔🏼 E5.0 man: medium-light skin tone, beard # emoji-test.txt line #542 Emoji version 13.0
is Uni.new(0x1F9D4, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D4, 0x1F3FC⟆ 🧔🏼 E5.0 man: medium-light skin tone, beard";
## 1F9D4 1F3FD                                ; fully-qualified     # 🧔🏽 E5.0 man: medium skin tone, beard # emoji-test.txt line #543 Emoji version 13.0
is Uni.new(0x1F9D4, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D4, 0x1F3FD⟆ 🧔🏽 E5.0 man: medium skin tone, beard";
## 1F9D4 1F3FE                                ; fully-qualified     # 🧔🏾 E5.0 man: medium-dark skin tone, beard # emoji-test.txt line #544 Emoji version 13.0
is Uni.new(0x1F9D4, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D4, 0x1F3FE⟆ 🧔🏾 E5.0 man: medium-dark skin tone, beard";
## 1F9D4 1F3FF                                ; fully-qualified     # 🧔🏿 E5.0 man: dark skin tone, beard # emoji-test.txt line #545 Emoji version 13.0
is Uni.new(0x1F9D4, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D4, 0x1F3FF⟆ 🧔🏿 E5.0 man: dark skin tone, beard";
## 1F468 200D 1F9B0                           ; fully-qualified     # 👨‍🦰 E11.0 man: red hair # emoji-test.txt line #546 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F9B0⟆ 👨‍🦰 E11.0 man: red hair";
## 1F468 1F3FB 200D 1F9B0                     ; fully-qualified     # 👨🏻‍🦰 E11.0 man: light skin tone, red hair # emoji-test.txt line #547 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F9B0⟆ 👨🏻‍🦰 E11.0 man: light skin tone, red hair";
## 1F468 1F3FC 200D 1F9B0                     ; fully-qualified     # 👨🏼‍🦰 E11.0 man: medium-light skin tone, red hair # emoji-test.txt line #548 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F9B0⟆ 👨🏼‍🦰 E11.0 man: medium-light skin tone, red hair";
## 1F468 1F3FD 200D 1F9B0                     ; fully-qualified     # 👨🏽‍🦰 E11.0 man: medium skin tone, red hair # emoji-test.txt line #549 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F9B0⟆ 👨🏽‍🦰 E11.0 man: medium skin tone, red hair";
## 1F468 1F3FE 200D 1F9B0                     ; fully-qualified     # 👨🏾‍🦰 E11.0 man: medium-dark skin tone, red hair # emoji-test.txt line #550 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F9B0⟆ 👨🏾‍🦰 E11.0 man: medium-dark skin tone, red hair";
## 1F468 1F3FF 200D 1F9B0                     ; fully-qualified     # 👨🏿‍🦰 E11.0 man: dark skin tone, red hair # emoji-test.txt line #551 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F9B0⟆ 👨🏿‍🦰 E11.0 man: dark skin tone, red hair";
## 1F468 200D 1F9B1                           ; fully-qualified     # 👨‍🦱 E11.0 man: curly hair # emoji-test.txt line #552 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F9B1⟆ 👨‍🦱 E11.0 man: curly hair";
## 1F468 1F3FB 200D 1F9B1                     ; fully-qualified     # 👨🏻‍🦱 E11.0 man: light skin tone, curly hair # emoji-test.txt line #553 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F9B1⟆ 👨🏻‍🦱 E11.0 man: light skin tone, curly hair";
## 1F468 1F3FC 200D 1F9B1                     ; fully-qualified     # 👨🏼‍🦱 E11.0 man: medium-light skin tone, curly hair # emoji-test.txt line #554 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F9B1⟆ 👨🏼‍🦱 E11.0 man: medium-light skin tone, curly hair";
## 1F468 1F3FD 200D 1F9B1                     ; fully-qualified     # 👨🏽‍🦱 E11.0 man: medium skin tone, curly hair # emoji-test.txt line #555 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F9B1⟆ 👨🏽‍🦱 E11.0 man: medium skin tone, curly hair";
## 1F468 1F3FE 200D 1F9B1                     ; fully-qualified     # 👨🏾‍🦱 E11.0 man: medium-dark skin tone, curly hair # emoji-test.txt line #556 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F9B1⟆ 👨🏾‍🦱 E11.0 man: medium-dark skin tone, curly hair";
## 1F468 1F3FF 200D 1F9B1                     ; fully-qualified     # 👨🏿‍🦱 E11.0 man: dark skin tone, curly hair # emoji-test.txt line #557 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F9B1⟆ 👨🏿‍🦱 E11.0 man: dark skin tone, curly hair";
## 1F468 200D 1F9B3                           ; fully-qualified     # 👨‍🦳 E11.0 man: white hair # emoji-test.txt line #558 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F9B3⟆ 👨‍🦳 E11.0 man: white hair";
## 1F468 1F3FB 200D 1F9B3                     ; fully-qualified     # 👨🏻‍🦳 E11.0 man: light skin tone, white hair # emoji-test.txt line #559 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F9B3⟆ 👨🏻‍🦳 E11.0 man: light skin tone, white hair";
## 1F468 1F3FC 200D 1F9B3                     ; fully-qualified     # 👨🏼‍🦳 E11.0 man: medium-light skin tone, white hair # emoji-test.txt line #560 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F9B3⟆ 👨🏼‍🦳 E11.0 man: medium-light skin tone, white hair";
## 1F468 1F3FD 200D 1F9B3                     ; fully-qualified     # 👨🏽‍🦳 E11.0 man: medium skin tone, white hair # emoji-test.txt line #561 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F9B3⟆ 👨🏽‍🦳 E11.0 man: medium skin tone, white hair";
## 1F468 1F3FE 200D 1F9B3                     ; fully-qualified     # 👨🏾‍🦳 E11.0 man: medium-dark skin tone, white hair # emoji-test.txt line #562 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F9B3⟆ 👨🏾‍🦳 E11.0 man: medium-dark skin tone, white hair";
## 1F468 1F3FF 200D 1F9B3                     ; fully-qualified     # 👨🏿‍🦳 E11.0 man: dark skin tone, white hair # emoji-test.txt line #563 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F9B3⟆ 👨🏿‍🦳 E11.0 man: dark skin tone, white hair";
## 1F468 200D 1F9B2                           ; fully-qualified     # 👨‍🦲 E11.0 man: bald # emoji-test.txt line #564 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F9B2⟆ 👨‍🦲 E11.0 man: bald";
## 1F468 1F3FB 200D 1F9B2                     ; fully-qualified     # 👨🏻‍🦲 E11.0 man: light skin tone, bald # emoji-test.txt line #565 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F9B2⟆ 👨🏻‍🦲 E11.0 man: light skin tone, bald";
## 1F468 1F3FC 200D 1F9B2                     ; fully-qualified     # 👨🏼‍🦲 E11.0 man: medium-light skin tone, bald # emoji-test.txt line #566 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F9B2⟆ 👨🏼‍🦲 E11.0 man: medium-light skin tone, bald";
## 1F468 1F3FD 200D 1F9B2                     ; fully-qualified     # 👨🏽‍🦲 E11.0 man: medium skin tone, bald # emoji-test.txt line #567 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F9B2⟆ 👨🏽‍🦲 E11.0 man: medium skin tone, bald";
## 1F468 1F3FE 200D 1F9B2                     ; fully-qualified     # 👨🏾‍🦲 E11.0 man: medium-dark skin tone, bald # emoji-test.txt line #568 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F9B2⟆ 👨🏾‍🦲 E11.0 man: medium-dark skin tone, bald";
## 1F468 1F3FF 200D 1F9B2                     ; fully-qualified     # 👨🏿‍🦲 E11.0 man: dark skin tone, bald # emoji-test.txt line #569 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F9B2⟆ 👨🏿‍🦲 E11.0 man: dark skin tone, bald";
## 1F469 1F3FB                                ; fully-qualified     # 👩🏻 E1.0 woman: light skin tone # emoji-test.txt line #571 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB⟆ 👩🏻 E1.0 woman: light skin tone";
## 1F469 1F3FC                                ; fully-qualified     # 👩🏼 E1.0 woman: medium-light skin tone # emoji-test.txt line #572 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC⟆ 👩🏼 E1.0 woman: medium-light skin tone";
## 1F469 1F3FD                                ; fully-qualified     # 👩🏽 E1.0 woman: medium skin tone # emoji-test.txt line #573 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD⟆ 👩🏽 E1.0 woman: medium skin tone";
## 1F469 1F3FE                                ; fully-qualified     # 👩🏾 E1.0 woman: medium-dark skin tone # emoji-test.txt line #574 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE⟆ 👩🏾 E1.0 woman: medium-dark skin tone";
## 1F469 1F3FF                                ; fully-qualified     # 👩🏿 E1.0 woman: dark skin tone # emoji-test.txt line #575 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF⟆ 👩🏿 E1.0 woman: dark skin tone";
## 1F469 200D 1F9B0                           ; fully-qualified     # 👩‍🦰 E11.0 woman: red hair # emoji-test.txt line #576 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F9B0⟆ 👩‍🦰 E11.0 woman: red hair";
## 1F469 1F3FB 200D 1F9B0                     ; fully-qualified     # 👩🏻‍🦰 E11.0 woman: light skin tone, red hair # emoji-test.txt line #577 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F9B0⟆ 👩🏻‍🦰 E11.0 woman: light skin tone, red hair";
## 1F469 1F3FC 200D 1F9B0                     ; fully-qualified     # 👩🏼‍🦰 E11.0 woman: medium-light skin tone, red hair # emoji-test.txt line #578 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F9B0⟆ 👩🏼‍🦰 E11.0 woman: medium-light skin tone, red hair";
## 1F469 1F3FD 200D 1F9B0                     ; fully-qualified     # 👩🏽‍🦰 E11.0 woman: medium skin tone, red hair # emoji-test.txt line #579 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F9B0⟆ 👩🏽‍🦰 E11.0 woman: medium skin tone, red hair";
## 1F469 1F3FE 200D 1F9B0                     ; fully-qualified     # 👩🏾‍🦰 E11.0 woman: medium-dark skin tone, red hair # emoji-test.txt line #580 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F9B0⟆ 👩🏾‍🦰 E11.0 woman: medium-dark skin tone, red hair";
## 1F469 1F3FF 200D 1F9B0                     ; fully-qualified     # 👩🏿‍🦰 E11.0 woman: dark skin tone, red hair # emoji-test.txt line #581 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F9B0⟆ 👩🏿‍🦰 E11.0 woman: dark skin tone, red hair";
## 1F9D1 200D 1F9B0                           ; fully-qualified     # 🧑‍🦰 E12.1 person: red hair # emoji-test.txt line #582 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F9B0⟆ 🧑‍🦰 E12.1 person: red hair";
## 1F9D1 1F3FB 200D 1F9B0                     ; fully-qualified     # 🧑🏻‍🦰 E12.1 person: light skin tone, red hair # emoji-test.txt line #583 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F9B0⟆ 🧑🏻‍🦰 E12.1 person: light skin tone, red hair";
## 1F9D1 1F3FC 200D 1F9B0                     ; fully-qualified     # 🧑🏼‍🦰 E12.1 person: medium-light skin tone, red hair # emoji-test.txt line #584 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F9B0⟆ 🧑🏼‍🦰 E12.1 person: medium-light skin tone, red hair";
## 1F9D1 1F3FD 200D 1F9B0                     ; fully-qualified     # 🧑🏽‍🦰 E12.1 person: medium skin tone, red hair # emoji-test.txt line #585 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F9B0⟆ 🧑🏽‍🦰 E12.1 person: medium skin tone, red hair";
## 1F9D1 1F3FE 200D 1F9B0                     ; fully-qualified     # 🧑🏾‍🦰 E12.1 person: medium-dark skin tone, red hair # emoji-test.txt line #586 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F9B0⟆ 🧑🏾‍🦰 E12.1 person: medium-dark skin tone, red hair";
## 1F9D1 1F3FF 200D 1F9B0                     ; fully-qualified     # 🧑🏿‍🦰 E12.1 person: dark skin tone, red hair # emoji-test.txt line #587 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F9B0).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F9B0⟆ 🧑🏿‍🦰 E12.1 person: dark skin tone, red hair";
## 1F469 200D 1F9B1                           ; fully-qualified     # 👩‍🦱 E11.0 woman: curly hair # emoji-test.txt line #588 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F9B1⟆ 👩‍🦱 E11.0 woman: curly hair";
## 1F469 1F3FB 200D 1F9B1                     ; fully-qualified     # 👩🏻‍🦱 E11.0 woman: light skin tone, curly hair # emoji-test.txt line #589 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F9B1⟆ 👩🏻‍🦱 E11.0 woman: light skin tone, curly hair";
## 1F469 1F3FC 200D 1F9B1                     ; fully-qualified     # 👩🏼‍🦱 E11.0 woman: medium-light skin tone, curly hair # emoji-test.txt line #590 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F9B1⟆ 👩🏼‍🦱 E11.0 woman: medium-light skin tone, curly hair";
## 1F469 1F3FD 200D 1F9B1                     ; fully-qualified     # 👩🏽‍🦱 E11.0 woman: medium skin tone, curly hair # emoji-test.txt line #591 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F9B1⟆ 👩🏽‍🦱 E11.0 woman: medium skin tone, curly hair";
## 1F469 1F3FE 200D 1F9B1                     ; fully-qualified     # 👩🏾‍🦱 E11.0 woman: medium-dark skin tone, curly hair # emoji-test.txt line #592 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F9B1⟆ 👩🏾‍🦱 E11.0 woman: medium-dark skin tone, curly hair";
## 1F469 1F3FF 200D 1F9B1                     ; fully-qualified     # 👩🏿‍🦱 E11.0 woman: dark skin tone, curly hair # emoji-test.txt line #593 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F9B1⟆ 👩🏿‍🦱 E11.0 woman: dark skin tone, curly hair";
## 1F9D1 200D 1F9B1                           ; fully-qualified     # 🧑‍🦱 E12.1 person: curly hair # emoji-test.txt line #594 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F9B1⟆ 🧑‍🦱 E12.1 person: curly hair";
## 1F9D1 1F3FB 200D 1F9B1                     ; fully-qualified     # 🧑🏻‍🦱 E12.1 person: light skin tone, curly hair # emoji-test.txt line #595 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F9B1⟆ 🧑🏻‍🦱 E12.1 person: light skin tone, curly hair";
## 1F9D1 1F3FC 200D 1F9B1                     ; fully-qualified     # 🧑🏼‍🦱 E12.1 person: medium-light skin tone, curly hair # emoji-test.txt line #596 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F9B1⟆ 🧑🏼‍🦱 E12.1 person: medium-light skin tone, curly hair";
## 1F9D1 1F3FD 200D 1F9B1                     ; fully-qualified     # 🧑🏽‍🦱 E12.1 person: medium skin tone, curly hair # emoji-test.txt line #597 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F9B1⟆ 🧑🏽‍🦱 E12.1 person: medium skin tone, curly hair";
## 1F9D1 1F3FE 200D 1F9B1                     ; fully-qualified     # 🧑🏾‍🦱 E12.1 person: medium-dark skin tone, curly hair # emoji-test.txt line #598 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F9B1⟆ 🧑🏾‍🦱 E12.1 person: medium-dark skin tone, curly hair";
## 1F9D1 1F3FF 200D 1F9B1                     ; fully-qualified     # 🧑🏿‍🦱 E12.1 person: dark skin tone, curly hair # emoji-test.txt line #599 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F9B1).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F9B1⟆ 🧑🏿‍🦱 E12.1 person: dark skin tone, curly hair";
## 1F469 200D 1F9B3                           ; fully-qualified     # 👩‍🦳 E11.0 woman: white hair # emoji-test.txt line #600 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F9B3⟆ 👩‍🦳 E11.0 woman: white hair";
## 1F469 1F3FB 200D 1F9B3                     ; fully-qualified     # 👩🏻‍🦳 E11.0 woman: light skin tone, white hair # emoji-test.txt line #601 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F9B3⟆ 👩🏻‍🦳 E11.0 woman: light skin tone, white hair";
## 1F469 1F3FC 200D 1F9B3                     ; fully-qualified     # 👩🏼‍🦳 E11.0 woman: medium-light skin tone, white hair # emoji-test.txt line #602 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F9B3⟆ 👩🏼‍🦳 E11.0 woman: medium-light skin tone, white hair";
## 1F469 1F3FD 200D 1F9B3                     ; fully-qualified     # 👩🏽‍🦳 E11.0 woman: medium skin tone, white hair # emoji-test.txt line #603 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F9B3⟆ 👩🏽‍🦳 E11.0 woman: medium skin tone, white hair";
## 1F469 1F3FE 200D 1F9B3                     ; fully-qualified     # 👩🏾‍🦳 E11.0 woman: medium-dark skin tone, white hair # emoji-test.txt line #604 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F9B3⟆ 👩🏾‍🦳 E11.0 woman: medium-dark skin tone, white hair";
## 1F469 1F3FF 200D 1F9B3                     ; fully-qualified     # 👩🏿‍🦳 E11.0 woman: dark skin tone, white hair # emoji-test.txt line #605 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F9B3⟆ 👩🏿‍🦳 E11.0 woman: dark skin tone, white hair";
## 1F9D1 200D 1F9B3                           ; fully-qualified     # 🧑‍🦳 E12.1 person: white hair # emoji-test.txt line #606 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F9B3⟆ 🧑‍🦳 E12.1 person: white hair";
## 1F9D1 1F3FB 200D 1F9B3                     ; fully-qualified     # 🧑🏻‍🦳 E12.1 person: light skin tone, white hair # emoji-test.txt line #607 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F9B3⟆ 🧑🏻‍🦳 E12.1 person: light skin tone, white hair";
## 1F9D1 1F3FC 200D 1F9B3                     ; fully-qualified     # 🧑🏼‍🦳 E12.1 person: medium-light skin tone, white hair # emoji-test.txt line #608 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F9B3⟆ 🧑🏼‍🦳 E12.1 person: medium-light skin tone, white hair";
## 1F9D1 1F3FD 200D 1F9B3                     ; fully-qualified     # 🧑🏽‍🦳 E12.1 person: medium skin tone, white hair # emoji-test.txt line #609 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F9B3⟆ 🧑🏽‍🦳 E12.1 person: medium skin tone, white hair";
## 1F9D1 1F3FE 200D 1F9B3                     ; fully-qualified     # 🧑🏾‍🦳 E12.1 person: medium-dark skin tone, white hair # emoji-test.txt line #610 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F9B3⟆ 🧑🏾‍🦳 E12.1 person: medium-dark skin tone, white hair";
## 1F9D1 1F3FF 200D 1F9B3                     ; fully-qualified     # 🧑🏿‍🦳 E12.1 person: dark skin tone, white hair # emoji-test.txt line #611 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F9B3).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F9B3⟆ 🧑🏿‍🦳 E12.1 person: dark skin tone, white hair";
## 1F469 200D 1F9B2                           ; fully-qualified     # 👩‍🦲 E11.0 woman: bald # emoji-test.txt line #612 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F9B2⟆ 👩‍🦲 E11.0 woman: bald";
## 1F469 1F3FB 200D 1F9B2                     ; fully-qualified     # 👩🏻‍🦲 E11.0 woman: light skin tone, bald # emoji-test.txt line #613 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F9B2⟆ 👩🏻‍🦲 E11.0 woman: light skin tone, bald";
## 1F469 1F3FC 200D 1F9B2                     ; fully-qualified     # 👩🏼‍🦲 E11.0 woman: medium-light skin tone, bald # emoji-test.txt line #614 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F9B2⟆ 👩🏼‍🦲 E11.0 woman: medium-light skin tone, bald";
## 1F469 1F3FD 200D 1F9B2                     ; fully-qualified     # 👩🏽‍🦲 E11.0 woman: medium skin tone, bald # emoji-test.txt line #615 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F9B2⟆ 👩🏽‍🦲 E11.0 woman: medium skin tone, bald";
## 1F469 1F3FE 200D 1F9B2                     ; fully-qualified     # 👩🏾‍🦲 E11.0 woman: medium-dark skin tone, bald # emoji-test.txt line #616 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F9B2⟆ 👩🏾‍🦲 E11.0 woman: medium-dark skin tone, bald";
## 1F469 1F3FF 200D 1F9B2                     ; fully-qualified     # 👩🏿‍🦲 E11.0 woman: dark skin tone, bald # emoji-test.txt line #617 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F9B2⟆ 👩🏿‍🦲 E11.0 woman: dark skin tone, bald";
## 1F9D1 200D 1F9B2                           ; fully-qualified     # 🧑‍🦲 E12.1 person: bald # emoji-test.txt line #618 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F9B2⟆ 🧑‍🦲 E12.1 person: bald";
## 1F9D1 1F3FB 200D 1F9B2                     ; fully-qualified     # 🧑🏻‍🦲 E12.1 person: light skin tone, bald # emoji-test.txt line #619 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F9B2⟆ 🧑🏻‍🦲 E12.1 person: light skin tone, bald";
## 1F9D1 1F3FC 200D 1F9B2                     ; fully-qualified     # 🧑🏼‍🦲 E12.1 person: medium-light skin tone, bald # emoji-test.txt line #620 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F9B2⟆ 🧑🏼‍🦲 E12.1 person: medium-light skin tone, bald";
## 1F9D1 1F3FD 200D 1F9B2                     ; fully-qualified     # 🧑🏽‍🦲 E12.1 person: medium skin tone, bald # emoji-test.txt line #621 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F9B2⟆ 🧑🏽‍🦲 E12.1 person: medium skin tone, bald";
## 1F9D1 1F3FE 200D 1F9B2                     ; fully-qualified     # 🧑🏾‍🦲 E12.1 person: medium-dark skin tone, bald # emoji-test.txt line #622 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F9B2⟆ 🧑🏾‍🦲 E12.1 person: medium-dark skin tone, bald";
## 1F9D1 1F3FF 200D 1F9B2                     ; fully-qualified     # 🧑🏿‍🦲 E12.1 person: dark skin tone, bald # emoji-test.txt line #623 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F9B2).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F9B2⟆ 🧑🏿‍🦲 E12.1 person: dark skin tone, bald";
## 1F471 200D 2640 FE0F                       ; fully-qualified     # 👱‍♀️ E4.0 woman: blond hair # emoji-test.txt line #624 Emoji version 13.0
is Uni.new(0x1F471, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x200D, 0x2640, 0xFE0F⟆ 👱‍♀️ E4.0 woman: blond hair";
## 1F471 200D 2640                            ; minimally-qualified # 👱‍♀ E4.0 woman: blond hair # emoji-test.txt line #625 Emoji version 13.0
is Uni.new(0x1F471, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F471, 0x200D, 0x2640⟆ 👱‍♀ E4.0 woman: blond hair";
## 1F471 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 👱🏻‍♀️ E4.0 woman: light skin tone, blond hair # emoji-test.txt line #626 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 👱🏻‍♀️ E4.0 woman: light skin tone, blond hair";
## 1F471 1F3FB 200D 2640                      ; minimally-qualified # 👱🏻‍♀ E4.0 woman: light skin tone, blond hair # emoji-test.txt line #627 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FB, 0x200D, 0x2640⟆ 👱🏻‍♀ E4.0 woman: light skin tone, blond hair";
## 1F471 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 👱🏼‍♀️ E4.0 woman: medium-light skin tone, blond hair # emoji-test.txt line #628 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 👱🏼‍♀️ E4.0 woman: medium-light skin tone, blond hair";
## 1F471 1F3FC 200D 2640                      ; minimally-qualified # 👱🏼‍♀ E4.0 woman: medium-light skin tone, blond hair # emoji-test.txt line #629 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FC, 0x200D, 0x2640⟆ 👱🏼‍♀ E4.0 woman: medium-light skin tone, blond hair";
## 1F471 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 👱🏽‍♀️ E4.0 woman: medium skin tone, blond hair # emoji-test.txt line #630 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 👱🏽‍♀️ E4.0 woman: medium skin tone, blond hair";
## 1F471 1F3FD 200D 2640                      ; minimally-qualified # 👱🏽‍♀ E4.0 woman: medium skin tone, blond hair # emoji-test.txt line #631 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FD, 0x200D, 0x2640⟆ 👱🏽‍♀ E4.0 woman: medium skin tone, blond hair";
## 1F471 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 👱🏾‍♀️ E4.0 woman: medium-dark skin tone, blond hair # emoji-test.txt line #632 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 👱🏾‍♀️ E4.0 woman: medium-dark skin tone, blond hair";
## 1F471 1F3FE 200D 2640                      ; minimally-qualified # 👱🏾‍♀ E4.0 woman: medium-dark skin tone, blond hair # emoji-test.txt line #633 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FE, 0x200D, 0x2640⟆ 👱🏾‍♀ E4.0 woman: medium-dark skin tone, blond hair";
## 1F471 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 👱🏿‍♀️ E4.0 woman: dark skin tone, blond hair # emoji-test.txt line #634 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 👱🏿‍♀️ E4.0 woman: dark skin tone, blond hair";
## 1F471 1F3FF 200D 2640                      ; minimally-qualified # 👱🏿‍♀ E4.0 woman: dark skin tone, blond hair # emoji-test.txt line #635 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FF, 0x200D, 0x2640⟆ 👱🏿‍♀ E4.0 woman: dark skin tone, blond hair";
## 1F471 200D 2642 FE0F                       ; fully-qualified     # 👱‍♂️ E4.0 man: blond hair # emoji-test.txt line #636 Emoji version 13.0
is Uni.new(0x1F471, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x200D, 0x2642, 0xFE0F⟆ 👱‍♂️ E4.0 man: blond hair";
## 1F471 200D 2642                            ; minimally-qualified # 👱‍♂ E4.0 man: blond hair # emoji-test.txt line #637 Emoji version 13.0
is Uni.new(0x1F471, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F471, 0x200D, 0x2642⟆ 👱‍♂ E4.0 man: blond hair";
## 1F471 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 👱🏻‍♂️ E4.0 man: light skin tone, blond hair # emoji-test.txt line #638 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 👱🏻‍♂️ E4.0 man: light skin tone, blond hair";
## 1F471 1F3FB 200D 2642                      ; minimally-qualified # 👱🏻‍♂ E4.0 man: light skin tone, blond hair # emoji-test.txt line #639 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FB, 0x200D, 0x2642⟆ 👱🏻‍♂ E4.0 man: light skin tone, blond hair";
## 1F471 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 👱🏼‍♂️ E4.0 man: medium-light skin tone, blond hair # emoji-test.txt line #640 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 👱🏼‍♂️ E4.0 man: medium-light skin tone, blond hair";
## 1F471 1F3FC 200D 2642                      ; minimally-qualified # 👱🏼‍♂ E4.0 man: medium-light skin tone, blond hair # emoji-test.txt line #641 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FC, 0x200D, 0x2642⟆ 👱🏼‍♂ E4.0 man: medium-light skin tone, blond hair";
## 1F471 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 👱🏽‍♂️ E4.0 man: medium skin tone, blond hair # emoji-test.txt line #642 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 👱🏽‍♂️ E4.0 man: medium skin tone, blond hair";
## 1F471 1F3FD 200D 2642                      ; minimally-qualified # 👱🏽‍♂ E4.0 man: medium skin tone, blond hair # emoji-test.txt line #643 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FD, 0x200D, 0x2642⟆ 👱🏽‍♂ E4.0 man: medium skin tone, blond hair";
## 1F471 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 👱🏾‍♂️ E4.0 man: medium-dark skin tone, blond hair # emoji-test.txt line #644 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 👱🏾‍♂️ E4.0 man: medium-dark skin tone, blond hair";
## 1F471 1F3FE 200D 2642                      ; minimally-qualified # 👱🏾‍♂ E4.0 man: medium-dark skin tone, blond hair # emoji-test.txt line #645 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FE, 0x200D, 0x2642⟆ 👱🏾‍♂ E4.0 man: medium-dark skin tone, blond hair";
## 1F471 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 👱🏿‍♂️ E4.0 man: dark skin tone, blond hair # emoji-test.txt line #646 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 👱🏿‍♂️ E4.0 man: dark skin tone, blond hair";
## 1F471 1F3FF 200D 2642                      ; minimally-qualified # 👱🏿‍♂ E4.0 man: dark skin tone, blond hair # emoji-test.txt line #647 Emoji version 13.0
is Uni.new(0x1F471, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F471, 0x1F3FF, 0x200D, 0x2642⟆ 👱🏿‍♂ E4.0 man: dark skin tone, blond hair";
## 1F9D3 1F3FB                                ; fully-qualified     # 🧓🏻 E5.0 older person: light skin tone # emoji-test.txt line #649 Emoji version 13.0
is Uni.new(0x1F9D3, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D3, 0x1F3FB⟆ 🧓🏻 E5.0 older person: light skin tone";
## 1F9D3 1F3FC                                ; fully-qualified     # 🧓🏼 E5.0 older person: medium-light skin tone # emoji-test.txt line #650 Emoji version 13.0
is Uni.new(0x1F9D3, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D3, 0x1F3FC⟆ 🧓🏼 E5.0 older person: medium-light skin tone";
## 1F9D3 1F3FD                                ; fully-qualified     # 🧓🏽 E5.0 older person: medium skin tone # emoji-test.txt line #651 Emoji version 13.0
is Uni.new(0x1F9D3, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D3, 0x1F3FD⟆ 🧓🏽 E5.0 older person: medium skin tone";
## 1F9D3 1F3FE                                ; fully-qualified     # 🧓🏾 E5.0 older person: medium-dark skin tone # emoji-test.txt line #652 Emoji version 13.0
is Uni.new(0x1F9D3, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D3, 0x1F3FE⟆ 🧓🏾 E5.0 older person: medium-dark skin tone";
## 1F9D3 1F3FF                                ; fully-qualified     # 🧓🏿 E5.0 older person: dark skin tone # emoji-test.txt line #653 Emoji version 13.0
is Uni.new(0x1F9D3, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D3, 0x1F3FF⟆ 🧓🏿 E5.0 older person: dark skin tone";
## 1F474 1F3FB                                ; fully-qualified     # 👴🏻 E1.0 old man: light skin tone # emoji-test.txt line #655 Emoji version 13.0
is Uni.new(0x1F474, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F474, 0x1F3FB⟆ 👴🏻 E1.0 old man: light skin tone";
## 1F474 1F3FC                                ; fully-qualified     # 👴🏼 E1.0 old man: medium-light skin tone # emoji-test.txt line #656 Emoji version 13.0
is Uni.new(0x1F474, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F474, 0x1F3FC⟆ 👴🏼 E1.0 old man: medium-light skin tone";
## 1F474 1F3FD                                ; fully-qualified     # 👴🏽 E1.0 old man: medium skin tone # emoji-test.txt line #657 Emoji version 13.0
is Uni.new(0x1F474, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F474, 0x1F3FD⟆ 👴🏽 E1.0 old man: medium skin tone";
## 1F474 1F3FE                                ; fully-qualified     # 👴🏾 E1.0 old man: medium-dark skin tone # emoji-test.txt line #658 Emoji version 13.0
is Uni.new(0x1F474, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F474, 0x1F3FE⟆ 👴🏾 E1.0 old man: medium-dark skin tone";
## 1F474 1F3FF                                ; fully-qualified     # 👴🏿 E1.0 old man: dark skin tone # emoji-test.txt line #659 Emoji version 13.0
is Uni.new(0x1F474, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F474, 0x1F3FF⟆ 👴🏿 E1.0 old man: dark skin tone";
## 1F475 1F3FB                                ; fully-qualified     # 👵🏻 E1.0 old woman: light skin tone # emoji-test.txt line #661 Emoji version 13.0
is Uni.new(0x1F475, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F475, 0x1F3FB⟆ 👵🏻 E1.0 old woman: light skin tone";
## 1F475 1F3FC                                ; fully-qualified     # 👵🏼 E1.0 old woman: medium-light skin tone # emoji-test.txt line #662 Emoji version 13.0
is Uni.new(0x1F475, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F475, 0x1F3FC⟆ 👵🏼 E1.0 old woman: medium-light skin tone";
## 1F475 1F3FD                                ; fully-qualified     # 👵🏽 E1.0 old woman: medium skin tone # emoji-test.txt line #663 Emoji version 13.0
is Uni.new(0x1F475, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F475, 0x1F3FD⟆ 👵🏽 E1.0 old woman: medium skin tone";
## 1F475 1F3FE                                ; fully-qualified     # 👵🏾 E1.0 old woman: medium-dark skin tone # emoji-test.txt line #664 Emoji version 13.0
is Uni.new(0x1F475, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F475, 0x1F3FE⟆ 👵🏾 E1.0 old woman: medium-dark skin tone";
## 1F475 1F3FF                                ; fully-qualified     # 👵🏿 E1.0 old woman: dark skin tone # emoji-test.txt line #665 Emoji version 13.0
is Uni.new(0x1F475, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F475, 0x1F3FF⟆ 👵🏿 E1.0 old woman: dark skin tone";
## 1F64D 1F3FB                                ; fully-qualified     # 🙍🏻 E1.0 person frowning: light skin tone # emoji-test.txt line #669 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FB⟆ 🙍🏻 E1.0 person frowning: light skin tone";
## 1F64D 1F3FC                                ; fully-qualified     # 🙍🏼 E1.0 person frowning: medium-light skin tone # emoji-test.txt line #670 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FC⟆ 🙍🏼 E1.0 person frowning: medium-light skin tone";
## 1F64D 1F3FD                                ; fully-qualified     # 🙍🏽 E1.0 person frowning: medium skin tone # emoji-test.txt line #671 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FD⟆ 🙍🏽 E1.0 person frowning: medium skin tone";
## 1F64D 1F3FE                                ; fully-qualified     # 🙍🏾 E1.0 person frowning: medium-dark skin tone # emoji-test.txt line #672 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FE⟆ 🙍🏾 E1.0 person frowning: medium-dark skin tone";
## 1F64D 1F3FF                                ; fully-qualified     # 🙍🏿 E1.0 person frowning: dark skin tone # emoji-test.txt line #673 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FF⟆ 🙍🏿 E1.0 person frowning: dark skin tone";
## 1F64D 200D 2642 FE0F                       ; fully-qualified     # 🙍‍♂️ E4.0 man frowning # emoji-test.txt line #674 Emoji version 13.0
is Uni.new(0x1F64D, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x200D, 0x2642, 0xFE0F⟆ 🙍‍♂️ E4.0 man frowning";
## 1F64D 200D 2642                            ; minimally-qualified # 🙍‍♂ E4.0 man frowning # emoji-test.txt line #675 Emoji version 13.0
is Uni.new(0x1F64D, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64D, 0x200D, 0x2642⟆ 🙍‍♂ E4.0 man frowning";
## 1F64D 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🙍🏻‍♂️ E4.0 man frowning: light skin tone # emoji-test.txt line #676 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🙍🏻‍♂️ E4.0 man frowning: light skin tone";
## 1F64D 1F3FB 200D 2642                      ; minimally-qualified # 🙍🏻‍♂ E4.0 man frowning: light skin tone # emoji-test.txt line #677 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FB, 0x200D, 0x2642⟆ 🙍🏻‍♂ E4.0 man frowning: light skin tone";
## 1F64D 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🙍🏼‍♂️ E4.0 man frowning: medium-light skin tone # emoji-test.txt line #678 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🙍🏼‍♂️ E4.0 man frowning: medium-light skin tone";
## 1F64D 1F3FC 200D 2642                      ; minimally-qualified # 🙍🏼‍♂ E4.0 man frowning: medium-light skin tone # emoji-test.txt line #679 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FC, 0x200D, 0x2642⟆ 🙍🏼‍♂ E4.0 man frowning: medium-light skin tone";
## 1F64D 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🙍🏽‍♂️ E4.0 man frowning: medium skin tone # emoji-test.txt line #680 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🙍🏽‍♂️ E4.0 man frowning: medium skin tone";
## 1F64D 1F3FD 200D 2642                      ; minimally-qualified # 🙍🏽‍♂ E4.0 man frowning: medium skin tone # emoji-test.txt line #681 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FD, 0x200D, 0x2642⟆ 🙍🏽‍♂ E4.0 man frowning: medium skin tone";
## 1F64D 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🙍🏾‍♂️ E4.0 man frowning: medium-dark skin tone # emoji-test.txt line #682 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🙍🏾‍♂️ E4.0 man frowning: medium-dark skin tone";
## 1F64D 1F3FE 200D 2642                      ; minimally-qualified # 🙍🏾‍♂ E4.0 man frowning: medium-dark skin tone # emoji-test.txt line #683 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FE, 0x200D, 0x2642⟆ 🙍🏾‍♂ E4.0 man frowning: medium-dark skin tone";
## 1F64D 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🙍🏿‍♂️ E4.0 man frowning: dark skin tone # emoji-test.txt line #684 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🙍🏿‍♂️ E4.0 man frowning: dark skin tone";
## 1F64D 1F3FF 200D 2642                      ; minimally-qualified # 🙍🏿‍♂ E4.0 man frowning: dark skin tone # emoji-test.txt line #685 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FF, 0x200D, 0x2642⟆ 🙍🏿‍♂ E4.0 man frowning: dark skin tone";
## 1F64D 200D 2640 FE0F                       ; fully-qualified     # 🙍‍♀️ E4.0 woman frowning # emoji-test.txt line #686 Emoji version 13.0
is Uni.new(0x1F64D, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x200D, 0x2640, 0xFE0F⟆ 🙍‍♀️ E4.0 woman frowning";
## 1F64D 200D 2640                            ; minimally-qualified # 🙍‍♀ E4.0 woman frowning # emoji-test.txt line #687 Emoji version 13.0
is Uni.new(0x1F64D, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64D, 0x200D, 0x2640⟆ 🙍‍♀ E4.0 woman frowning";
## 1F64D 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🙍🏻‍♀️ E4.0 woman frowning: light skin tone # emoji-test.txt line #688 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🙍🏻‍♀️ E4.0 woman frowning: light skin tone";
## 1F64D 1F3FB 200D 2640                      ; minimally-qualified # 🙍🏻‍♀ E4.0 woman frowning: light skin tone # emoji-test.txt line #689 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FB, 0x200D, 0x2640⟆ 🙍🏻‍♀ E4.0 woman frowning: light skin tone";
## 1F64D 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🙍🏼‍♀️ E4.0 woman frowning: medium-light skin tone # emoji-test.txt line #690 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🙍🏼‍♀️ E4.0 woman frowning: medium-light skin tone";
## 1F64D 1F3FC 200D 2640                      ; minimally-qualified # 🙍🏼‍♀ E4.0 woman frowning: medium-light skin tone # emoji-test.txt line #691 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FC, 0x200D, 0x2640⟆ 🙍🏼‍♀ E4.0 woman frowning: medium-light skin tone";
## 1F64D 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🙍🏽‍♀️ E4.0 woman frowning: medium skin tone # emoji-test.txt line #692 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🙍🏽‍♀️ E4.0 woman frowning: medium skin tone";
## 1F64D 1F3FD 200D 2640                      ; minimally-qualified # 🙍🏽‍♀ E4.0 woman frowning: medium skin tone # emoji-test.txt line #693 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FD, 0x200D, 0x2640⟆ 🙍🏽‍♀ E4.0 woman frowning: medium skin tone";
## 1F64D 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🙍🏾‍♀️ E4.0 woman frowning: medium-dark skin tone # emoji-test.txt line #694 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🙍🏾‍♀️ E4.0 woman frowning: medium-dark skin tone";
## 1F64D 1F3FE 200D 2640                      ; minimally-qualified # 🙍🏾‍♀ E4.0 woman frowning: medium-dark skin tone # emoji-test.txt line #695 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FE, 0x200D, 0x2640⟆ 🙍🏾‍♀ E4.0 woman frowning: medium-dark skin tone";
## 1F64D 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🙍🏿‍♀️ E4.0 woman frowning: dark skin tone # emoji-test.txt line #696 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🙍🏿‍♀️ E4.0 woman frowning: dark skin tone";
## 1F64D 1F3FF 200D 2640                      ; minimally-qualified # 🙍🏿‍♀ E4.0 woman frowning: dark skin tone # emoji-test.txt line #697 Emoji version 13.0
is Uni.new(0x1F64D, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64D, 0x1F3FF, 0x200D, 0x2640⟆ 🙍🏿‍♀ E4.0 woman frowning: dark skin tone";
## 1F64E 1F3FB                                ; fully-qualified     # 🙎🏻 E1.0 person pouting: light skin tone # emoji-test.txt line #699 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FB⟆ 🙎🏻 E1.0 person pouting: light skin tone";
## 1F64E 1F3FC                                ; fully-qualified     # 🙎🏼 E1.0 person pouting: medium-light skin tone # emoji-test.txt line #700 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FC⟆ 🙎🏼 E1.0 person pouting: medium-light skin tone";
## 1F64E 1F3FD                                ; fully-qualified     # 🙎🏽 E1.0 person pouting: medium skin tone # emoji-test.txt line #701 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FD⟆ 🙎🏽 E1.0 person pouting: medium skin tone";
## 1F64E 1F3FE                                ; fully-qualified     # 🙎🏾 E1.0 person pouting: medium-dark skin tone # emoji-test.txt line #702 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FE⟆ 🙎🏾 E1.0 person pouting: medium-dark skin tone";
## 1F64E 1F3FF                                ; fully-qualified     # 🙎🏿 E1.0 person pouting: dark skin tone # emoji-test.txt line #703 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FF⟆ 🙎🏿 E1.0 person pouting: dark skin tone";
## 1F64E 200D 2642 FE0F                       ; fully-qualified     # 🙎‍♂️ E4.0 man pouting # emoji-test.txt line #704 Emoji version 13.0
is Uni.new(0x1F64E, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x200D, 0x2642, 0xFE0F⟆ 🙎‍♂️ E4.0 man pouting";
## 1F64E 200D 2642                            ; minimally-qualified # 🙎‍♂ E4.0 man pouting # emoji-test.txt line #705 Emoji version 13.0
is Uni.new(0x1F64E, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64E, 0x200D, 0x2642⟆ 🙎‍♂ E4.0 man pouting";
## 1F64E 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🙎🏻‍♂️ E4.0 man pouting: light skin tone # emoji-test.txt line #706 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🙎🏻‍♂️ E4.0 man pouting: light skin tone";
## 1F64E 1F3FB 200D 2642                      ; minimally-qualified # 🙎🏻‍♂ E4.0 man pouting: light skin tone # emoji-test.txt line #707 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FB, 0x200D, 0x2642⟆ 🙎🏻‍♂ E4.0 man pouting: light skin tone";
## 1F64E 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🙎🏼‍♂️ E4.0 man pouting: medium-light skin tone # emoji-test.txt line #708 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🙎🏼‍♂️ E4.0 man pouting: medium-light skin tone";
## 1F64E 1F3FC 200D 2642                      ; minimally-qualified # 🙎🏼‍♂ E4.0 man pouting: medium-light skin tone # emoji-test.txt line #709 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FC, 0x200D, 0x2642⟆ 🙎🏼‍♂ E4.0 man pouting: medium-light skin tone";
## 1F64E 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🙎🏽‍♂️ E4.0 man pouting: medium skin tone # emoji-test.txt line #710 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🙎🏽‍♂️ E4.0 man pouting: medium skin tone";
## 1F64E 1F3FD 200D 2642                      ; minimally-qualified # 🙎🏽‍♂ E4.0 man pouting: medium skin tone # emoji-test.txt line #711 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FD, 0x200D, 0x2642⟆ 🙎🏽‍♂ E4.0 man pouting: medium skin tone";
## 1F64E 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🙎🏾‍♂️ E4.0 man pouting: medium-dark skin tone # emoji-test.txt line #712 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🙎🏾‍♂️ E4.0 man pouting: medium-dark skin tone";
## 1F64E 1F3FE 200D 2642                      ; minimally-qualified # 🙎🏾‍♂ E4.0 man pouting: medium-dark skin tone # emoji-test.txt line #713 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FE, 0x200D, 0x2642⟆ 🙎🏾‍♂ E4.0 man pouting: medium-dark skin tone";
## 1F64E 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🙎🏿‍♂️ E4.0 man pouting: dark skin tone # emoji-test.txt line #714 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🙎🏿‍♂️ E4.0 man pouting: dark skin tone";
## 1F64E 1F3FF 200D 2642                      ; minimally-qualified # 🙎🏿‍♂ E4.0 man pouting: dark skin tone # emoji-test.txt line #715 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FF, 0x200D, 0x2642⟆ 🙎🏿‍♂ E4.0 man pouting: dark skin tone";
## 1F64E 200D 2640 FE0F                       ; fully-qualified     # 🙎‍♀️ E4.0 woman pouting # emoji-test.txt line #716 Emoji version 13.0
is Uni.new(0x1F64E, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x200D, 0x2640, 0xFE0F⟆ 🙎‍♀️ E4.0 woman pouting";
## 1F64E 200D 2640                            ; minimally-qualified # 🙎‍♀ E4.0 woman pouting # emoji-test.txt line #717 Emoji version 13.0
is Uni.new(0x1F64E, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64E, 0x200D, 0x2640⟆ 🙎‍♀ E4.0 woman pouting";
## 1F64E 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🙎🏻‍♀️ E4.0 woman pouting: light skin tone # emoji-test.txt line #718 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🙎🏻‍♀️ E4.0 woman pouting: light skin tone";
## 1F64E 1F3FB 200D 2640                      ; minimally-qualified # 🙎🏻‍♀ E4.0 woman pouting: light skin tone # emoji-test.txt line #719 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FB, 0x200D, 0x2640⟆ 🙎🏻‍♀ E4.0 woman pouting: light skin tone";
## 1F64E 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🙎🏼‍♀️ E4.0 woman pouting: medium-light skin tone # emoji-test.txt line #720 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🙎🏼‍♀️ E4.0 woman pouting: medium-light skin tone";
## 1F64E 1F3FC 200D 2640                      ; minimally-qualified # 🙎🏼‍♀ E4.0 woman pouting: medium-light skin tone # emoji-test.txt line #721 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FC, 0x200D, 0x2640⟆ 🙎🏼‍♀ E4.0 woman pouting: medium-light skin tone";
## 1F64E 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🙎🏽‍♀️ E4.0 woman pouting: medium skin tone # emoji-test.txt line #722 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🙎🏽‍♀️ E4.0 woman pouting: medium skin tone";
## 1F64E 1F3FD 200D 2640                      ; minimally-qualified # 🙎🏽‍♀ E4.0 woman pouting: medium skin tone # emoji-test.txt line #723 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FD, 0x200D, 0x2640⟆ 🙎🏽‍♀ E4.0 woman pouting: medium skin tone";
## 1F64E 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🙎🏾‍♀️ E4.0 woman pouting: medium-dark skin tone # emoji-test.txt line #724 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🙎🏾‍♀️ E4.0 woman pouting: medium-dark skin tone";
## 1F64E 1F3FE 200D 2640                      ; minimally-qualified # 🙎🏾‍♀ E4.0 woman pouting: medium-dark skin tone # emoji-test.txt line #725 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FE, 0x200D, 0x2640⟆ 🙎🏾‍♀ E4.0 woman pouting: medium-dark skin tone";
## 1F64E 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🙎🏿‍♀️ E4.0 woman pouting: dark skin tone # emoji-test.txt line #726 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🙎🏿‍♀️ E4.0 woman pouting: dark skin tone";
## 1F64E 1F3FF 200D 2640                      ; minimally-qualified # 🙎🏿‍♀ E4.0 woman pouting: dark skin tone # emoji-test.txt line #727 Emoji version 13.0
is Uni.new(0x1F64E, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64E, 0x1F3FF, 0x200D, 0x2640⟆ 🙎🏿‍♀ E4.0 woman pouting: dark skin tone";
## 1F645 1F3FB                                ; fully-qualified     # 🙅🏻 E1.0 person gesturing NO: light skin tone # emoji-test.txt line #729 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FB⟆ 🙅🏻 E1.0 person gesturing NO: light skin tone";
## 1F645 1F3FC                                ; fully-qualified     # 🙅🏼 E1.0 person gesturing NO: medium-light skin tone # emoji-test.txt line #730 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FC⟆ 🙅🏼 E1.0 person gesturing NO: medium-light skin tone";
## 1F645 1F3FD                                ; fully-qualified     # 🙅🏽 E1.0 person gesturing NO: medium skin tone # emoji-test.txt line #731 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FD⟆ 🙅🏽 E1.0 person gesturing NO: medium skin tone";
## 1F645 1F3FE                                ; fully-qualified     # 🙅🏾 E1.0 person gesturing NO: medium-dark skin tone # emoji-test.txt line #732 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FE⟆ 🙅🏾 E1.0 person gesturing NO: medium-dark skin tone";
## 1F645 1F3FF                                ; fully-qualified     # 🙅🏿 E1.0 person gesturing NO: dark skin tone # emoji-test.txt line #733 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FF⟆ 🙅🏿 E1.0 person gesturing NO: dark skin tone";
## 1F645 200D 2642 FE0F                       ; fully-qualified     # 🙅‍♂️ E4.0 man gesturing NO # emoji-test.txt line #734 Emoji version 13.0
is Uni.new(0x1F645, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x200D, 0x2642, 0xFE0F⟆ 🙅‍♂️ E4.0 man gesturing NO";
## 1F645 200D 2642                            ; minimally-qualified # 🙅‍♂ E4.0 man gesturing NO # emoji-test.txt line #735 Emoji version 13.0
is Uni.new(0x1F645, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F645, 0x200D, 0x2642⟆ 🙅‍♂ E4.0 man gesturing NO";
## 1F645 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🙅🏻‍♂️ E4.0 man gesturing NO: light skin tone # emoji-test.txt line #736 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🙅🏻‍♂️ E4.0 man gesturing NO: light skin tone";
## 1F645 1F3FB 200D 2642                      ; minimally-qualified # 🙅🏻‍♂ E4.0 man gesturing NO: light skin tone # emoji-test.txt line #737 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FB, 0x200D, 0x2642⟆ 🙅🏻‍♂ E4.0 man gesturing NO: light skin tone";
## 1F645 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🙅🏼‍♂️ E4.0 man gesturing NO: medium-light skin tone # emoji-test.txt line #738 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🙅🏼‍♂️ E4.0 man gesturing NO: medium-light skin tone";
## 1F645 1F3FC 200D 2642                      ; minimally-qualified # 🙅🏼‍♂ E4.0 man gesturing NO: medium-light skin tone # emoji-test.txt line #739 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FC, 0x200D, 0x2642⟆ 🙅🏼‍♂ E4.0 man gesturing NO: medium-light skin tone";
## 1F645 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🙅🏽‍♂️ E4.0 man gesturing NO: medium skin tone # emoji-test.txt line #740 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🙅🏽‍♂️ E4.0 man gesturing NO: medium skin tone";
## 1F645 1F3FD 200D 2642                      ; minimally-qualified # 🙅🏽‍♂ E4.0 man gesturing NO: medium skin tone # emoji-test.txt line #741 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FD, 0x200D, 0x2642⟆ 🙅🏽‍♂ E4.0 man gesturing NO: medium skin tone";
## 1F645 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🙅🏾‍♂️ E4.0 man gesturing NO: medium-dark skin tone # emoji-test.txt line #742 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🙅🏾‍♂️ E4.0 man gesturing NO: medium-dark skin tone";
## 1F645 1F3FE 200D 2642                      ; minimally-qualified # 🙅🏾‍♂ E4.0 man gesturing NO: medium-dark skin tone # emoji-test.txt line #743 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FE, 0x200D, 0x2642⟆ 🙅🏾‍♂ E4.0 man gesturing NO: medium-dark skin tone";
## 1F645 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🙅🏿‍♂️ E4.0 man gesturing NO: dark skin tone # emoji-test.txt line #744 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🙅🏿‍♂️ E4.0 man gesturing NO: dark skin tone";
## 1F645 1F3FF 200D 2642                      ; minimally-qualified # 🙅🏿‍♂ E4.0 man gesturing NO: dark skin tone # emoji-test.txt line #745 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FF, 0x200D, 0x2642⟆ 🙅🏿‍♂ E4.0 man gesturing NO: dark skin tone";
## 1F645 200D 2640 FE0F                       ; fully-qualified     # 🙅‍♀️ E4.0 woman gesturing NO # emoji-test.txt line #746 Emoji version 13.0
is Uni.new(0x1F645, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x200D, 0x2640, 0xFE0F⟆ 🙅‍♀️ E4.0 woman gesturing NO";
## 1F645 200D 2640                            ; minimally-qualified # 🙅‍♀ E4.0 woman gesturing NO # emoji-test.txt line #747 Emoji version 13.0
is Uni.new(0x1F645, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F645, 0x200D, 0x2640⟆ 🙅‍♀ E4.0 woman gesturing NO";
## 1F645 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🙅🏻‍♀️ E4.0 woman gesturing NO: light skin tone # emoji-test.txt line #748 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🙅🏻‍♀️ E4.0 woman gesturing NO: light skin tone";
## 1F645 1F3FB 200D 2640                      ; minimally-qualified # 🙅🏻‍♀ E4.0 woman gesturing NO: light skin tone # emoji-test.txt line #749 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FB, 0x200D, 0x2640⟆ 🙅🏻‍♀ E4.0 woman gesturing NO: light skin tone";
## 1F645 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🙅🏼‍♀️ E4.0 woman gesturing NO: medium-light skin tone # emoji-test.txt line #750 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🙅🏼‍♀️ E4.0 woman gesturing NO: medium-light skin tone";
## 1F645 1F3FC 200D 2640                      ; minimally-qualified # 🙅🏼‍♀ E4.0 woman gesturing NO: medium-light skin tone # emoji-test.txt line #751 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FC, 0x200D, 0x2640⟆ 🙅🏼‍♀ E4.0 woman gesturing NO: medium-light skin tone";
## 1F645 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🙅🏽‍♀️ E4.0 woman gesturing NO: medium skin tone # emoji-test.txt line #752 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🙅🏽‍♀️ E4.0 woman gesturing NO: medium skin tone";
## 1F645 1F3FD 200D 2640                      ; minimally-qualified # 🙅🏽‍♀ E4.0 woman gesturing NO: medium skin tone # emoji-test.txt line #753 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FD, 0x200D, 0x2640⟆ 🙅🏽‍♀ E4.0 woman gesturing NO: medium skin tone";
## 1F645 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🙅🏾‍♀️ E4.0 woman gesturing NO: medium-dark skin tone # emoji-test.txt line #754 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🙅🏾‍♀️ E4.0 woman gesturing NO: medium-dark skin tone";
## 1F645 1F3FE 200D 2640                      ; minimally-qualified # 🙅🏾‍♀ E4.0 woman gesturing NO: medium-dark skin tone # emoji-test.txt line #755 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FE, 0x200D, 0x2640⟆ 🙅🏾‍♀ E4.0 woman gesturing NO: medium-dark skin tone";
## 1F645 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🙅🏿‍♀️ E4.0 woman gesturing NO: dark skin tone # emoji-test.txt line #756 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🙅🏿‍♀️ E4.0 woman gesturing NO: dark skin tone";
## 1F645 1F3FF 200D 2640                      ; minimally-qualified # 🙅🏿‍♀ E4.0 woman gesturing NO: dark skin tone # emoji-test.txt line #757 Emoji version 13.0
is Uni.new(0x1F645, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F645, 0x1F3FF, 0x200D, 0x2640⟆ 🙅🏿‍♀ E4.0 woman gesturing NO: dark skin tone";
## 1F646 1F3FB                                ; fully-qualified     # 🙆🏻 E1.0 person gesturing OK: light skin tone # emoji-test.txt line #759 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FB⟆ 🙆🏻 E1.0 person gesturing OK: light skin tone";
## 1F646 1F3FC                                ; fully-qualified     # 🙆🏼 E1.0 person gesturing OK: medium-light skin tone # emoji-test.txt line #760 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FC⟆ 🙆🏼 E1.0 person gesturing OK: medium-light skin tone";
## 1F646 1F3FD                                ; fully-qualified     # 🙆🏽 E1.0 person gesturing OK: medium skin tone # emoji-test.txt line #761 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FD⟆ 🙆🏽 E1.0 person gesturing OK: medium skin tone";
## 1F646 1F3FE                                ; fully-qualified     # 🙆🏾 E1.0 person gesturing OK: medium-dark skin tone # emoji-test.txt line #762 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FE⟆ 🙆🏾 E1.0 person gesturing OK: medium-dark skin tone";
## 1F646 1F3FF                                ; fully-qualified     # 🙆🏿 E1.0 person gesturing OK: dark skin tone # emoji-test.txt line #763 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FF⟆ 🙆🏿 E1.0 person gesturing OK: dark skin tone";
## 1F646 200D 2642 FE0F                       ; fully-qualified     # 🙆‍♂️ E4.0 man gesturing OK # emoji-test.txt line #764 Emoji version 13.0
is Uni.new(0x1F646, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x200D, 0x2642, 0xFE0F⟆ 🙆‍♂️ E4.0 man gesturing OK";
## 1F646 200D 2642                            ; minimally-qualified # 🙆‍♂ E4.0 man gesturing OK # emoji-test.txt line #765 Emoji version 13.0
is Uni.new(0x1F646, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F646, 0x200D, 0x2642⟆ 🙆‍♂ E4.0 man gesturing OK";
## 1F646 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🙆🏻‍♂️ E4.0 man gesturing OK: light skin tone # emoji-test.txt line #766 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🙆🏻‍♂️ E4.0 man gesturing OK: light skin tone";
## 1F646 1F3FB 200D 2642                      ; minimally-qualified # 🙆🏻‍♂ E4.0 man gesturing OK: light skin tone # emoji-test.txt line #767 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FB, 0x200D, 0x2642⟆ 🙆🏻‍♂ E4.0 man gesturing OK: light skin tone";
## 1F646 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🙆🏼‍♂️ E4.0 man gesturing OK: medium-light skin tone # emoji-test.txt line #768 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🙆🏼‍♂️ E4.0 man gesturing OK: medium-light skin tone";
## 1F646 1F3FC 200D 2642                      ; minimally-qualified # 🙆🏼‍♂ E4.0 man gesturing OK: medium-light skin tone # emoji-test.txt line #769 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FC, 0x200D, 0x2642⟆ 🙆🏼‍♂ E4.0 man gesturing OK: medium-light skin tone";
## 1F646 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🙆🏽‍♂️ E4.0 man gesturing OK: medium skin tone # emoji-test.txt line #770 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🙆🏽‍♂️ E4.0 man gesturing OK: medium skin tone";
## 1F646 1F3FD 200D 2642                      ; minimally-qualified # 🙆🏽‍♂ E4.0 man gesturing OK: medium skin tone # emoji-test.txt line #771 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FD, 0x200D, 0x2642⟆ 🙆🏽‍♂ E4.0 man gesturing OK: medium skin tone";
## 1F646 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🙆🏾‍♂️ E4.0 man gesturing OK: medium-dark skin tone # emoji-test.txt line #772 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🙆🏾‍♂️ E4.0 man gesturing OK: medium-dark skin tone";
## 1F646 1F3FE 200D 2642                      ; minimally-qualified # 🙆🏾‍♂ E4.0 man gesturing OK: medium-dark skin tone # emoji-test.txt line #773 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FE, 0x200D, 0x2642⟆ 🙆🏾‍♂ E4.0 man gesturing OK: medium-dark skin tone";
## 1F646 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🙆🏿‍♂️ E4.0 man gesturing OK: dark skin tone # emoji-test.txt line #774 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🙆🏿‍♂️ E4.0 man gesturing OK: dark skin tone";
## 1F646 1F3FF 200D 2642                      ; minimally-qualified # 🙆🏿‍♂ E4.0 man gesturing OK: dark skin tone # emoji-test.txt line #775 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FF, 0x200D, 0x2642⟆ 🙆🏿‍♂ E4.0 man gesturing OK: dark skin tone";
## 1F646 200D 2640 FE0F                       ; fully-qualified     # 🙆‍♀️ E4.0 woman gesturing OK # emoji-test.txt line #776 Emoji version 13.0
is Uni.new(0x1F646, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x200D, 0x2640, 0xFE0F⟆ 🙆‍♀️ E4.0 woman gesturing OK";
## 1F646 200D 2640                            ; minimally-qualified # 🙆‍♀ E4.0 woman gesturing OK # emoji-test.txt line #777 Emoji version 13.0
is Uni.new(0x1F646, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F646, 0x200D, 0x2640⟆ 🙆‍♀ E4.0 woman gesturing OK";
## 1F646 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🙆🏻‍♀️ E4.0 woman gesturing OK: light skin tone # emoji-test.txt line #778 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🙆🏻‍♀️ E4.0 woman gesturing OK: light skin tone";
## 1F646 1F3FB 200D 2640                      ; minimally-qualified # 🙆🏻‍♀ E4.0 woman gesturing OK: light skin tone # emoji-test.txt line #779 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FB, 0x200D, 0x2640⟆ 🙆🏻‍♀ E4.0 woman gesturing OK: light skin tone";
## 1F646 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🙆🏼‍♀️ E4.0 woman gesturing OK: medium-light skin tone # emoji-test.txt line #780 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🙆🏼‍♀️ E4.0 woman gesturing OK: medium-light skin tone";
## 1F646 1F3FC 200D 2640                      ; minimally-qualified # 🙆🏼‍♀ E4.0 woman gesturing OK: medium-light skin tone # emoji-test.txt line #781 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FC, 0x200D, 0x2640⟆ 🙆🏼‍♀ E4.0 woman gesturing OK: medium-light skin tone";
## 1F646 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🙆🏽‍♀️ E4.0 woman gesturing OK: medium skin tone # emoji-test.txt line #782 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🙆🏽‍♀️ E4.0 woman gesturing OK: medium skin tone";
## 1F646 1F3FD 200D 2640                      ; minimally-qualified # 🙆🏽‍♀ E4.0 woman gesturing OK: medium skin tone # emoji-test.txt line #783 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FD, 0x200D, 0x2640⟆ 🙆🏽‍♀ E4.0 woman gesturing OK: medium skin tone";
## 1F646 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🙆🏾‍♀️ E4.0 woman gesturing OK: medium-dark skin tone # emoji-test.txt line #784 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🙆🏾‍♀️ E4.0 woman gesturing OK: medium-dark skin tone";
## 1F646 1F3FE 200D 2640                      ; minimally-qualified # 🙆🏾‍♀ E4.0 woman gesturing OK: medium-dark skin tone # emoji-test.txt line #785 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FE, 0x200D, 0x2640⟆ 🙆🏾‍♀ E4.0 woman gesturing OK: medium-dark skin tone";
## 1F646 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🙆🏿‍♀️ E4.0 woman gesturing OK: dark skin tone # emoji-test.txt line #786 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🙆🏿‍♀️ E4.0 woman gesturing OK: dark skin tone";
## 1F646 1F3FF 200D 2640                      ; minimally-qualified # 🙆🏿‍♀ E4.0 woman gesturing OK: dark skin tone # emoji-test.txt line #787 Emoji version 13.0
is Uni.new(0x1F646, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F646, 0x1F3FF, 0x200D, 0x2640⟆ 🙆🏿‍♀ E4.0 woman gesturing OK: dark skin tone";
## 1F481 1F3FB                                ; fully-qualified     # 💁🏻 E1.0 person tipping hand: light skin tone # emoji-test.txt line #789 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FB⟆ 💁🏻 E1.0 person tipping hand: light skin tone";
## 1F481 1F3FC                                ; fully-qualified     # 💁🏼 E1.0 person tipping hand: medium-light skin tone # emoji-test.txt line #790 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FC⟆ 💁🏼 E1.0 person tipping hand: medium-light skin tone";
## 1F481 1F3FD                                ; fully-qualified     # 💁🏽 E1.0 person tipping hand: medium skin tone # emoji-test.txt line #791 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FD⟆ 💁🏽 E1.0 person tipping hand: medium skin tone";
## 1F481 1F3FE                                ; fully-qualified     # 💁🏾 E1.0 person tipping hand: medium-dark skin tone # emoji-test.txt line #792 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FE⟆ 💁🏾 E1.0 person tipping hand: medium-dark skin tone";
## 1F481 1F3FF                                ; fully-qualified     # 💁🏿 E1.0 person tipping hand: dark skin tone # emoji-test.txt line #793 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FF⟆ 💁🏿 E1.0 person tipping hand: dark skin tone";
## 1F481 200D 2642 FE0F                       ; fully-qualified     # 💁‍♂️ E4.0 man tipping hand # emoji-test.txt line #794 Emoji version 13.0
is Uni.new(0x1F481, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x200D, 0x2642, 0xFE0F⟆ 💁‍♂️ E4.0 man tipping hand";
## 1F481 200D 2642                            ; minimally-qualified # 💁‍♂ E4.0 man tipping hand # emoji-test.txt line #795 Emoji version 13.0
is Uni.new(0x1F481, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F481, 0x200D, 0x2642⟆ 💁‍♂ E4.0 man tipping hand";
## 1F481 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 💁🏻‍♂️ E4.0 man tipping hand: light skin tone # emoji-test.txt line #796 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 💁🏻‍♂️ E4.0 man tipping hand: light skin tone";
## 1F481 1F3FB 200D 2642                      ; minimally-qualified # 💁🏻‍♂ E4.0 man tipping hand: light skin tone # emoji-test.txt line #797 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FB, 0x200D, 0x2642⟆ 💁🏻‍♂ E4.0 man tipping hand: light skin tone";
## 1F481 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 💁🏼‍♂️ E4.0 man tipping hand: medium-light skin tone # emoji-test.txt line #798 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 💁🏼‍♂️ E4.0 man tipping hand: medium-light skin tone";
## 1F481 1F3FC 200D 2642                      ; minimally-qualified # 💁🏼‍♂ E4.0 man tipping hand: medium-light skin tone # emoji-test.txt line #799 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FC, 0x200D, 0x2642⟆ 💁🏼‍♂ E4.0 man tipping hand: medium-light skin tone";
## 1F481 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 💁🏽‍♂️ E4.0 man tipping hand: medium skin tone # emoji-test.txt line #800 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 💁🏽‍♂️ E4.0 man tipping hand: medium skin tone";
## 1F481 1F3FD 200D 2642                      ; minimally-qualified # 💁🏽‍♂ E4.0 man tipping hand: medium skin tone # emoji-test.txt line #801 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FD, 0x200D, 0x2642⟆ 💁🏽‍♂ E4.0 man tipping hand: medium skin tone";
## 1F481 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 💁🏾‍♂️ E4.0 man tipping hand: medium-dark skin tone # emoji-test.txt line #802 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 💁🏾‍♂️ E4.0 man tipping hand: medium-dark skin tone";
## 1F481 1F3FE 200D 2642                      ; minimally-qualified # 💁🏾‍♂ E4.0 man tipping hand: medium-dark skin tone # emoji-test.txt line #803 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FE, 0x200D, 0x2642⟆ 💁🏾‍♂ E4.0 man tipping hand: medium-dark skin tone";
## 1F481 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 💁🏿‍♂️ E4.0 man tipping hand: dark skin tone # emoji-test.txt line #804 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 💁🏿‍♂️ E4.0 man tipping hand: dark skin tone";
## 1F481 1F3FF 200D 2642                      ; minimally-qualified # 💁🏿‍♂ E4.0 man tipping hand: dark skin tone # emoji-test.txt line #805 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FF, 0x200D, 0x2642⟆ 💁🏿‍♂ E4.0 man tipping hand: dark skin tone";
## 1F481 200D 2640 FE0F                       ; fully-qualified     # 💁‍♀️ E4.0 woman tipping hand # emoji-test.txt line #806 Emoji version 13.0
is Uni.new(0x1F481, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x200D, 0x2640, 0xFE0F⟆ 💁‍♀️ E4.0 woman tipping hand";
## 1F481 200D 2640                            ; minimally-qualified # 💁‍♀ E4.0 woman tipping hand # emoji-test.txt line #807 Emoji version 13.0
is Uni.new(0x1F481, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F481, 0x200D, 0x2640⟆ 💁‍♀ E4.0 woman tipping hand";
## 1F481 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 💁🏻‍♀️ E4.0 woman tipping hand: light skin tone # emoji-test.txt line #808 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 💁🏻‍♀️ E4.0 woman tipping hand: light skin tone";
## 1F481 1F3FB 200D 2640                      ; minimally-qualified # 💁🏻‍♀ E4.0 woman tipping hand: light skin tone # emoji-test.txt line #809 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FB, 0x200D, 0x2640⟆ 💁🏻‍♀ E4.0 woman tipping hand: light skin tone";
## 1F481 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 💁🏼‍♀️ E4.0 woman tipping hand: medium-light skin tone # emoji-test.txt line #810 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 💁🏼‍♀️ E4.0 woman tipping hand: medium-light skin tone";
## 1F481 1F3FC 200D 2640                      ; minimally-qualified # 💁🏼‍♀ E4.0 woman tipping hand: medium-light skin tone # emoji-test.txt line #811 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FC, 0x200D, 0x2640⟆ 💁🏼‍♀ E4.0 woman tipping hand: medium-light skin tone";
## 1F481 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 💁🏽‍♀️ E4.0 woman tipping hand: medium skin tone # emoji-test.txt line #812 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 💁🏽‍♀️ E4.0 woman tipping hand: medium skin tone";
## 1F481 1F3FD 200D 2640                      ; minimally-qualified # 💁🏽‍♀ E4.0 woman tipping hand: medium skin tone # emoji-test.txt line #813 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FD, 0x200D, 0x2640⟆ 💁🏽‍♀ E4.0 woman tipping hand: medium skin tone";
## 1F481 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 💁🏾‍♀️ E4.0 woman tipping hand: medium-dark skin tone # emoji-test.txt line #814 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 💁🏾‍♀️ E4.0 woman tipping hand: medium-dark skin tone";
## 1F481 1F3FE 200D 2640                      ; minimally-qualified # 💁🏾‍♀ E4.0 woman tipping hand: medium-dark skin tone # emoji-test.txt line #815 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FE, 0x200D, 0x2640⟆ 💁🏾‍♀ E4.0 woman tipping hand: medium-dark skin tone";
## 1F481 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 💁🏿‍♀️ E4.0 woman tipping hand: dark skin tone # emoji-test.txt line #816 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 💁🏿‍♀️ E4.0 woman tipping hand: dark skin tone";
## 1F481 1F3FF 200D 2640                      ; minimally-qualified # 💁🏿‍♀ E4.0 woman tipping hand: dark skin tone # emoji-test.txt line #817 Emoji version 13.0
is Uni.new(0x1F481, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F481, 0x1F3FF, 0x200D, 0x2640⟆ 💁🏿‍♀ E4.0 woman tipping hand: dark skin tone";
## 1F64B 1F3FB                                ; fully-qualified     # 🙋🏻 E1.0 person raising hand: light skin tone # emoji-test.txt line #819 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FB⟆ 🙋🏻 E1.0 person raising hand: light skin tone";
## 1F64B 1F3FC                                ; fully-qualified     # 🙋🏼 E1.0 person raising hand: medium-light skin tone # emoji-test.txt line #820 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FC⟆ 🙋🏼 E1.0 person raising hand: medium-light skin tone";
## 1F64B 1F3FD                                ; fully-qualified     # 🙋🏽 E1.0 person raising hand: medium skin tone # emoji-test.txt line #821 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FD⟆ 🙋🏽 E1.0 person raising hand: medium skin tone";
## 1F64B 1F3FE                                ; fully-qualified     # 🙋🏾 E1.0 person raising hand: medium-dark skin tone # emoji-test.txt line #822 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FE⟆ 🙋🏾 E1.0 person raising hand: medium-dark skin tone";
## 1F64B 1F3FF                                ; fully-qualified     # 🙋🏿 E1.0 person raising hand: dark skin tone # emoji-test.txt line #823 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FF⟆ 🙋🏿 E1.0 person raising hand: dark skin tone";
## 1F64B 200D 2642 FE0F                       ; fully-qualified     # 🙋‍♂️ E4.0 man raising hand # emoji-test.txt line #824 Emoji version 13.0
is Uni.new(0x1F64B, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x200D, 0x2642, 0xFE0F⟆ 🙋‍♂️ E4.0 man raising hand";
## 1F64B 200D 2642                            ; minimally-qualified # 🙋‍♂ E4.0 man raising hand # emoji-test.txt line #825 Emoji version 13.0
is Uni.new(0x1F64B, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64B, 0x200D, 0x2642⟆ 🙋‍♂ E4.0 man raising hand";
## 1F64B 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🙋🏻‍♂️ E4.0 man raising hand: light skin tone # emoji-test.txt line #826 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🙋🏻‍♂️ E4.0 man raising hand: light skin tone";
## 1F64B 1F3FB 200D 2642                      ; minimally-qualified # 🙋🏻‍♂ E4.0 man raising hand: light skin tone # emoji-test.txt line #827 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FB, 0x200D, 0x2642⟆ 🙋🏻‍♂ E4.0 man raising hand: light skin tone";
## 1F64B 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🙋🏼‍♂️ E4.0 man raising hand: medium-light skin tone # emoji-test.txt line #828 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🙋🏼‍♂️ E4.0 man raising hand: medium-light skin tone";
## 1F64B 1F3FC 200D 2642                      ; minimally-qualified # 🙋🏼‍♂ E4.0 man raising hand: medium-light skin tone # emoji-test.txt line #829 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FC, 0x200D, 0x2642⟆ 🙋🏼‍♂ E4.0 man raising hand: medium-light skin tone";
## 1F64B 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🙋🏽‍♂️ E4.0 man raising hand: medium skin tone # emoji-test.txt line #830 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🙋🏽‍♂️ E4.0 man raising hand: medium skin tone";
## 1F64B 1F3FD 200D 2642                      ; minimally-qualified # 🙋🏽‍♂ E4.0 man raising hand: medium skin tone # emoji-test.txt line #831 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FD, 0x200D, 0x2642⟆ 🙋🏽‍♂ E4.0 man raising hand: medium skin tone";
## 1F64B 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🙋🏾‍♂️ E4.0 man raising hand: medium-dark skin tone # emoji-test.txt line #832 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🙋🏾‍♂️ E4.0 man raising hand: medium-dark skin tone";
## 1F64B 1F3FE 200D 2642                      ; minimally-qualified # 🙋🏾‍♂ E4.0 man raising hand: medium-dark skin tone # emoji-test.txt line #833 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FE, 0x200D, 0x2642⟆ 🙋🏾‍♂ E4.0 man raising hand: medium-dark skin tone";
## 1F64B 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🙋🏿‍♂️ E4.0 man raising hand: dark skin tone # emoji-test.txt line #834 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🙋🏿‍♂️ E4.0 man raising hand: dark skin tone";
## 1F64B 1F3FF 200D 2642                      ; minimally-qualified # 🙋🏿‍♂ E4.0 man raising hand: dark skin tone # emoji-test.txt line #835 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FF, 0x200D, 0x2642⟆ 🙋🏿‍♂ E4.0 man raising hand: dark skin tone";
## 1F64B 200D 2640 FE0F                       ; fully-qualified     # 🙋‍♀️ E4.0 woman raising hand # emoji-test.txt line #836 Emoji version 13.0
is Uni.new(0x1F64B, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x200D, 0x2640, 0xFE0F⟆ 🙋‍♀️ E4.0 woman raising hand";
## 1F64B 200D 2640                            ; minimally-qualified # 🙋‍♀ E4.0 woman raising hand # emoji-test.txt line #837 Emoji version 13.0
is Uni.new(0x1F64B, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64B, 0x200D, 0x2640⟆ 🙋‍♀ E4.0 woman raising hand";
## 1F64B 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🙋🏻‍♀️ E4.0 woman raising hand: light skin tone # emoji-test.txt line #838 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🙋🏻‍♀️ E4.0 woman raising hand: light skin tone";
## 1F64B 1F3FB 200D 2640                      ; minimally-qualified # 🙋🏻‍♀ E4.0 woman raising hand: light skin tone # emoji-test.txt line #839 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FB, 0x200D, 0x2640⟆ 🙋🏻‍♀ E4.0 woman raising hand: light skin tone";
## 1F64B 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🙋🏼‍♀️ E4.0 woman raising hand: medium-light skin tone # emoji-test.txt line #840 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🙋🏼‍♀️ E4.0 woman raising hand: medium-light skin tone";
## 1F64B 1F3FC 200D 2640                      ; minimally-qualified # 🙋🏼‍♀ E4.0 woman raising hand: medium-light skin tone # emoji-test.txt line #841 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FC, 0x200D, 0x2640⟆ 🙋🏼‍♀ E4.0 woman raising hand: medium-light skin tone";
## 1F64B 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🙋🏽‍♀️ E4.0 woman raising hand: medium skin tone # emoji-test.txt line #842 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🙋🏽‍♀️ E4.0 woman raising hand: medium skin tone";
## 1F64B 1F3FD 200D 2640                      ; minimally-qualified # 🙋🏽‍♀ E4.0 woman raising hand: medium skin tone # emoji-test.txt line #843 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FD, 0x200D, 0x2640⟆ 🙋🏽‍♀ E4.0 woman raising hand: medium skin tone";
## 1F64B 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🙋🏾‍♀️ E4.0 woman raising hand: medium-dark skin tone # emoji-test.txt line #844 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🙋🏾‍♀️ E4.0 woman raising hand: medium-dark skin tone";
## 1F64B 1F3FE 200D 2640                      ; minimally-qualified # 🙋🏾‍♀ E4.0 woman raising hand: medium-dark skin tone # emoji-test.txt line #845 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FE, 0x200D, 0x2640⟆ 🙋🏾‍♀ E4.0 woman raising hand: medium-dark skin tone";
## 1F64B 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🙋🏿‍♀️ E4.0 woman raising hand: dark skin tone # emoji-test.txt line #846 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🙋🏿‍♀️ E4.0 woman raising hand: dark skin tone";
## 1F64B 1F3FF 200D 2640                      ; minimally-qualified # 🙋🏿‍♀ E4.0 woman raising hand: dark skin tone # emoji-test.txt line #847 Emoji version 13.0
is Uni.new(0x1F64B, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F64B, 0x1F3FF, 0x200D, 0x2640⟆ 🙋🏿‍♀ E4.0 woman raising hand: dark skin tone";
## 1F9CF 1F3FB                                ; fully-qualified     # 🧏🏻 E12.0 deaf person: light skin tone # emoji-test.txt line #849 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FB⟆ 🧏🏻 E12.0 deaf person: light skin tone";
## 1F9CF 1F3FC                                ; fully-qualified     # 🧏🏼 E12.0 deaf person: medium-light skin tone # emoji-test.txt line #850 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FC⟆ 🧏🏼 E12.0 deaf person: medium-light skin tone";
## 1F9CF 1F3FD                                ; fully-qualified     # 🧏🏽 E12.0 deaf person: medium skin tone # emoji-test.txt line #851 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FD⟆ 🧏🏽 E12.0 deaf person: medium skin tone";
## 1F9CF 1F3FE                                ; fully-qualified     # 🧏🏾 E12.0 deaf person: medium-dark skin tone # emoji-test.txt line #852 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FE⟆ 🧏🏾 E12.0 deaf person: medium-dark skin tone";
## 1F9CF 1F3FF                                ; fully-qualified     # 🧏🏿 E12.0 deaf person: dark skin tone # emoji-test.txt line #853 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FF⟆ 🧏🏿 E12.0 deaf person: dark skin tone";
## 1F9CF 200D 2642 FE0F                       ; fully-qualified     # 🧏‍♂️ E12.0 deaf man # emoji-test.txt line #854 Emoji version 13.0
is Uni.new(0x1F9CF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x200D, 0x2642, 0xFE0F⟆ 🧏‍♂️ E12.0 deaf man";
## 1F9CF 200D 2642                            ; minimally-qualified # 🧏‍♂ E12.0 deaf man # emoji-test.txt line #855 Emoji version 13.0
is Uni.new(0x1F9CF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x200D, 0x2642⟆ 🧏‍♂ E12.0 deaf man";
## 1F9CF 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧏🏻‍♂️ E12.0 deaf man: light skin tone # emoji-test.txt line #856 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧏🏻‍♂️ E12.0 deaf man: light skin tone";
## 1F9CF 1F3FB 200D 2642                      ; minimally-qualified # 🧏🏻‍♂ E12.0 deaf man: light skin tone # emoji-test.txt line #857 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FB, 0x200D, 0x2642⟆ 🧏🏻‍♂ E12.0 deaf man: light skin tone";
## 1F9CF 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧏🏼‍♂️ E12.0 deaf man: medium-light skin tone # emoji-test.txt line #858 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧏🏼‍♂️ E12.0 deaf man: medium-light skin tone";
## 1F9CF 1F3FC 200D 2642                      ; minimally-qualified # 🧏🏼‍♂ E12.0 deaf man: medium-light skin tone # emoji-test.txt line #859 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FC, 0x200D, 0x2642⟆ 🧏🏼‍♂ E12.0 deaf man: medium-light skin tone";
## 1F9CF 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧏🏽‍♂️ E12.0 deaf man: medium skin tone # emoji-test.txt line #860 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧏🏽‍♂️ E12.0 deaf man: medium skin tone";
## 1F9CF 1F3FD 200D 2642                      ; minimally-qualified # 🧏🏽‍♂ E12.0 deaf man: medium skin tone # emoji-test.txt line #861 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FD, 0x200D, 0x2642⟆ 🧏🏽‍♂ E12.0 deaf man: medium skin tone";
## 1F9CF 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧏🏾‍♂️ E12.0 deaf man: medium-dark skin tone # emoji-test.txt line #862 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧏🏾‍♂️ E12.0 deaf man: medium-dark skin tone";
## 1F9CF 1F3FE 200D 2642                      ; minimally-qualified # 🧏🏾‍♂ E12.0 deaf man: medium-dark skin tone # emoji-test.txt line #863 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FE, 0x200D, 0x2642⟆ 🧏🏾‍♂ E12.0 deaf man: medium-dark skin tone";
## 1F9CF 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧏🏿‍♂️ E12.0 deaf man: dark skin tone # emoji-test.txt line #864 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧏🏿‍♂️ E12.0 deaf man: dark skin tone";
## 1F9CF 1F3FF 200D 2642                      ; minimally-qualified # 🧏🏿‍♂ E12.0 deaf man: dark skin tone # emoji-test.txt line #865 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FF, 0x200D, 0x2642⟆ 🧏🏿‍♂ E12.0 deaf man: dark skin tone";
## 1F9CF 200D 2640 FE0F                       ; fully-qualified     # 🧏‍♀️ E12.0 deaf woman # emoji-test.txt line #866 Emoji version 13.0
is Uni.new(0x1F9CF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x200D, 0x2640, 0xFE0F⟆ 🧏‍♀️ E12.0 deaf woman";
## 1F9CF 200D 2640                            ; minimally-qualified # 🧏‍♀ E12.0 deaf woman # emoji-test.txt line #867 Emoji version 13.0
is Uni.new(0x1F9CF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x200D, 0x2640⟆ 🧏‍♀ E12.0 deaf woman";
## 1F9CF 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧏🏻‍♀️ E12.0 deaf woman: light skin tone # emoji-test.txt line #868 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧏🏻‍♀️ E12.0 deaf woman: light skin tone";
## 1F9CF 1F3FB 200D 2640                      ; minimally-qualified # 🧏🏻‍♀ E12.0 deaf woman: light skin tone # emoji-test.txt line #869 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FB, 0x200D, 0x2640⟆ 🧏🏻‍♀ E12.0 deaf woman: light skin tone";
## 1F9CF 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧏🏼‍♀️ E12.0 deaf woman: medium-light skin tone # emoji-test.txt line #870 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧏🏼‍♀️ E12.0 deaf woman: medium-light skin tone";
## 1F9CF 1F3FC 200D 2640                      ; minimally-qualified # 🧏🏼‍♀ E12.0 deaf woman: medium-light skin tone # emoji-test.txt line #871 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FC, 0x200D, 0x2640⟆ 🧏🏼‍♀ E12.0 deaf woman: medium-light skin tone";
## 1F9CF 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧏🏽‍♀️ E12.0 deaf woman: medium skin tone # emoji-test.txt line #872 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧏🏽‍♀️ E12.0 deaf woman: medium skin tone";
## 1F9CF 1F3FD 200D 2640                      ; minimally-qualified # 🧏🏽‍♀ E12.0 deaf woman: medium skin tone # emoji-test.txt line #873 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FD, 0x200D, 0x2640⟆ 🧏🏽‍♀ E12.0 deaf woman: medium skin tone";
## 1F9CF 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧏🏾‍♀️ E12.0 deaf woman: medium-dark skin tone # emoji-test.txt line #874 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧏🏾‍♀️ E12.0 deaf woman: medium-dark skin tone";
## 1F9CF 1F3FE 200D 2640                      ; minimally-qualified # 🧏🏾‍♀ E12.0 deaf woman: medium-dark skin tone # emoji-test.txt line #875 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FE, 0x200D, 0x2640⟆ 🧏🏾‍♀ E12.0 deaf woman: medium-dark skin tone";
## 1F9CF 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧏🏿‍♀️ E12.0 deaf woman: dark skin tone # emoji-test.txt line #876 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧏🏿‍♀️ E12.0 deaf woman: dark skin tone";
## 1F9CF 1F3FF 200D 2640                      ; minimally-qualified # 🧏🏿‍♀ E12.0 deaf woman: dark skin tone # emoji-test.txt line #877 Emoji version 13.0
is Uni.new(0x1F9CF, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CF, 0x1F3FF, 0x200D, 0x2640⟆ 🧏🏿‍♀ E12.0 deaf woman: dark skin tone";
## 1F647 1F3FB                                ; fully-qualified     # 🙇🏻 E1.0 person bowing: light skin tone # emoji-test.txt line #879 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FB⟆ 🙇🏻 E1.0 person bowing: light skin tone";
## 1F647 1F3FC                                ; fully-qualified     # 🙇🏼 E1.0 person bowing: medium-light skin tone # emoji-test.txt line #880 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FC⟆ 🙇🏼 E1.0 person bowing: medium-light skin tone";
## 1F647 1F3FD                                ; fully-qualified     # 🙇🏽 E1.0 person bowing: medium skin tone # emoji-test.txt line #881 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FD⟆ 🙇🏽 E1.0 person bowing: medium skin tone";
## 1F647 1F3FE                                ; fully-qualified     # 🙇🏾 E1.0 person bowing: medium-dark skin tone # emoji-test.txt line #882 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FE⟆ 🙇🏾 E1.0 person bowing: medium-dark skin tone";
## 1F647 1F3FF                                ; fully-qualified     # 🙇🏿 E1.0 person bowing: dark skin tone # emoji-test.txt line #883 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FF⟆ 🙇🏿 E1.0 person bowing: dark skin tone";
## 1F647 200D 2642 FE0F                       ; fully-qualified     # 🙇‍♂️ E4.0 man bowing # emoji-test.txt line #884 Emoji version 13.0
is Uni.new(0x1F647, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x200D, 0x2642, 0xFE0F⟆ 🙇‍♂️ E4.0 man bowing";
## 1F647 200D 2642                            ; minimally-qualified # 🙇‍♂ E4.0 man bowing # emoji-test.txt line #885 Emoji version 13.0
is Uni.new(0x1F647, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F647, 0x200D, 0x2642⟆ 🙇‍♂ E4.0 man bowing";
## 1F647 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🙇🏻‍♂️ E4.0 man bowing: light skin tone # emoji-test.txt line #886 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🙇🏻‍♂️ E4.0 man bowing: light skin tone";
## 1F647 1F3FB 200D 2642                      ; minimally-qualified # 🙇🏻‍♂ E4.0 man bowing: light skin tone # emoji-test.txt line #887 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FB, 0x200D, 0x2642⟆ 🙇🏻‍♂ E4.0 man bowing: light skin tone";
## 1F647 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🙇🏼‍♂️ E4.0 man bowing: medium-light skin tone # emoji-test.txt line #888 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🙇🏼‍♂️ E4.0 man bowing: medium-light skin tone";
## 1F647 1F3FC 200D 2642                      ; minimally-qualified # 🙇🏼‍♂ E4.0 man bowing: medium-light skin tone # emoji-test.txt line #889 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FC, 0x200D, 0x2642⟆ 🙇🏼‍♂ E4.0 man bowing: medium-light skin tone";
## 1F647 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🙇🏽‍♂️ E4.0 man bowing: medium skin tone # emoji-test.txt line #890 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🙇🏽‍♂️ E4.0 man bowing: medium skin tone";
## 1F647 1F3FD 200D 2642                      ; minimally-qualified # 🙇🏽‍♂ E4.0 man bowing: medium skin tone # emoji-test.txt line #891 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FD, 0x200D, 0x2642⟆ 🙇🏽‍♂ E4.0 man bowing: medium skin tone";
## 1F647 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🙇🏾‍♂️ E4.0 man bowing: medium-dark skin tone # emoji-test.txt line #892 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🙇🏾‍♂️ E4.0 man bowing: medium-dark skin tone";
## 1F647 1F3FE 200D 2642                      ; minimally-qualified # 🙇🏾‍♂ E4.0 man bowing: medium-dark skin tone # emoji-test.txt line #893 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FE, 0x200D, 0x2642⟆ 🙇🏾‍♂ E4.0 man bowing: medium-dark skin tone";
## 1F647 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🙇🏿‍♂️ E4.0 man bowing: dark skin tone # emoji-test.txt line #894 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🙇🏿‍♂️ E4.0 man bowing: dark skin tone";
## 1F647 1F3FF 200D 2642                      ; minimally-qualified # 🙇🏿‍♂ E4.0 man bowing: dark skin tone # emoji-test.txt line #895 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FF, 0x200D, 0x2642⟆ 🙇🏿‍♂ E4.0 man bowing: dark skin tone";
## 1F647 200D 2640 FE0F                       ; fully-qualified     # 🙇‍♀️ E4.0 woman bowing # emoji-test.txt line #896 Emoji version 13.0
is Uni.new(0x1F647, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x200D, 0x2640, 0xFE0F⟆ 🙇‍♀️ E4.0 woman bowing";
## 1F647 200D 2640                            ; minimally-qualified # 🙇‍♀ E4.0 woman bowing # emoji-test.txt line #897 Emoji version 13.0
is Uni.new(0x1F647, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F647, 0x200D, 0x2640⟆ 🙇‍♀ E4.0 woman bowing";
## 1F647 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🙇🏻‍♀️ E4.0 woman bowing: light skin tone # emoji-test.txt line #898 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🙇🏻‍♀️ E4.0 woman bowing: light skin tone";
## 1F647 1F3FB 200D 2640                      ; minimally-qualified # 🙇🏻‍♀ E4.0 woman bowing: light skin tone # emoji-test.txt line #899 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FB, 0x200D, 0x2640⟆ 🙇🏻‍♀ E4.0 woman bowing: light skin tone";
## 1F647 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🙇🏼‍♀️ E4.0 woman bowing: medium-light skin tone # emoji-test.txt line #900 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🙇🏼‍♀️ E4.0 woman bowing: medium-light skin tone";
## 1F647 1F3FC 200D 2640                      ; minimally-qualified # 🙇🏼‍♀ E4.0 woman bowing: medium-light skin tone # emoji-test.txt line #901 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FC, 0x200D, 0x2640⟆ 🙇🏼‍♀ E4.0 woman bowing: medium-light skin tone";
## 1F647 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🙇🏽‍♀️ E4.0 woman bowing: medium skin tone # emoji-test.txt line #902 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🙇🏽‍♀️ E4.0 woman bowing: medium skin tone";
## 1F647 1F3FD 200D 2640                      ; minimally-qualified # 🙇🏽‍♀ E4.0 woman bowing: medium skin tone # emoji-test.txt line #903 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FD, 0x200D, 0x2640⟆ 🙇🏽‍♀ E4.0 woman bowing: medium skin tone";
## 1F647 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🙇🏾‍♀️ E4.0 woman bowing: medium-dark skin tone # emoji-test.txt line #904 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🙇🏾‍♀️ E4.0 woman bowing: medium-dark skin tone";
## 1F647 1F3FE 200D 2640                      ; minimally-qualified # 🙇🏾‍♀ E4.0 woman bowing: medium-dark skin tone # emoji-test.txt line #905 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FE, 0x200D, 0x2640⟆ 🙇🏾‍♀ E4.0 woman bowing: medium-dark skin tone";
## 1F647 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🙇🏿‍♀️ E4.0 woman bowing: dark skin tone # emoji-test.txt line #906 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🙇🏿‍♀️ E4.0 woman bowing: dark skin tone";
## 1F647 1F3FF 200D 2640                      ; minimally-qualified # 🙇🏿‍♀ E4.0 woman bowing: dark skin tone # emoji-test.txt line #907 Emoji version 13.0
is Uni.new(0x1F647, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F647, 0x1F3FF, 0x200D, 0x2640⟆ 🙇🏿‍♀ E4.0 woman bowing: dark skin tone";
## 1F926 1F3FB                                ; fully-qualified     # 🤦🏻 E3.0 person facepalming: light skin tone # emoji-test.txt line #909 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FB⟆ 🤦🏻 E3.0 person facepalming: light skin tone";
## 1F926 1F3FC                                ; fully-qualified     # 🤦🏼 E3.0 person facepalming: medium-light skin tone # emoji-test.txt line #910 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FC⟆ 🤦🏼 E3.0 person facepalming: medium-light skin tone";
## 1F926 1F3FD                                ; fully-qualified     # 🤦🏽 E3.0 person facepalming: medium skin tone # emoji-test.txt line #911 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FD⟆ 🤦🏽 E3.0 person facepalming: medium skin tone";
## 1F926 1F3FE                                ; fully-qualified     # 🤦🏾 E3.0 person facepalming: medium-dark skin tone # emoji-test.txt line #912 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FE⟆ 🤦🏾 E3.0 person facepalming: medium-dark skin tone";
## 1F926 1F3FF                                ; fully-qualified     # 🤦🏿 E3.0 person facepalming: dark skin tone # emoji-test.txt line #913 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FF⟆ 🤦🏿 E3.0 person facepalming: dark skin tone";
## 1F926 200D 2642 FE0F                       ; fully-qualified     # 🤦‍♂️ E4.0 man facepalming # emoji-test.txt line #914 Emoji version 13.0
is Uni.new(0x1F926, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x200D, 0x2642, 0xFE0F⟆ 🤦‍♂️ E4.0 man facepalming";
## 1F926 200D 2642                            ; minimally-qualified # 🤦‍♂ E4.0 man facepalming # emoji-test.txt line #915 Emoji version 13.0
is Uni.new(0x1F926, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F926, 0x200D, 0x2642⟆ 🤦‍♂ E4.0 man facepalming";
## 1F926 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🤦🏻‍♂️ E4.0 man facepalming: light skin tone # emoji-test.txt line #916 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🤦🏻‍♂️ E4.0 man facepalming: light skin tone";
## 1F926 1F3FB 200D 2642                      ; minimally-qualified # 🤦🏻‍♂ E4.0 man facepalming: light skin tone # emoji-test.txt line #917 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FB, 0x200D, 0x2642⟆ 🤦🏻‍♂ E4.0 man facepalming: light skin tone";
## 1F926 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🤦🏼‍♂️ E4.0 man facepalming: medium-light skin tone # emoji-test.txt line #918 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🤦🏼‍♂️ E4.0 man facepalming: medium-light skin tone";
## 1F926 1F3FC 200D 2642                      ; minimally-qualified # 🤦🏼‍♂ E4.0 man facepalming: medium-light skin tone # emoji-test.txt line #919 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FC, 0x200D, 0x2642⟆ 🤦🏼‍♂ E4.0 man facepalming: medium-light skin tone";
## 1F926 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🤦🏽‍♂️ E4.0 man facepalming: medium skin tone # emoji-test.txt line #920 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🤦🏽‍♂️ E4.0 man facepalming: medium skin tone";
## 1F926 1F3FD 200D 2642                      ; minimally-qualified # 🤦🏽‍♂ E4.0 man facepalming: medium skin tone # emoji-test.txt line #921 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FD, 0x200D, 0x2642⟆ 🤦🏽‍♂ E4.0 man facepalming: medium skin tone";
## 1F926 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🤦🏾‍♂️ E4.0 man facepalming: medium-dark skin tone # emoji-test.txt line #922 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🤦🏾‍♂️ E4.0 man facepalming: medium-dark skin tone";
## 1F926 1F3FE 200D 2642                      ; minimally-qualified # 🤦🏾‍♂ E4.0 man facepalming: medium-dark skin tone # emoji-test.txt line #923 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FE, 0x200D, 0x2642⟆ 🤦🏾‍♂ E4.0 man facepalming: medium-dark skin tone";
## 1F926 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🤦🏿‍♂️ E4.0 man facepalming: dark skin tone # emoji-test.txt line #924 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🤦🏿‍♂️ E4.0 man facepalming: dark skin tone";
## 1F926 1F3FF 200D 2642                      ; minimally-qualified # 🤦🏿‍♂ E4.0 man facepalming: dark skin tone # emoji-test.txt line #925 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FF, 0x200D, 0x2642⟆ 🤦🏿‍♂ E4.0 man facepalming: dark skin tone";
## 1F926 200D 2640 FE0F                       ; fully-qualified     # 🤦‍♀️ E4.0 woman facepalming # emoji-test.txt line #926 Emoji version 13.0
is Uni.new(0x1F926, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x200D, 0x2640, 0xFE0F⟆ 🤦‍♀️ E4.0 woman facepalming";
## 1F926 200D 2640                            ; minimally-qualified # 🤦‍♀ E4.0 woman facepalming # emoji-test.txt line #927 Emoji version 13.0
is Uni.new(0x1F926, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F926, 0x200D, 0x2640⟆ 🤦‍♀ E4.0 woman facepalming";
## 1F926 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🤦🏻‍♀️ E4.0 woman facepalming: light skin tone # emoji-test.txt line #928 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🤦🏻‍♀️ E4.0 woman facepalming: light skin tone";
## 1F926 1F3FB 200D 2640                      ; minimally-qualified # 🤦🏻‍♀ E4.0 woman facepalming: light skin tone # emoji-test.txt line #929 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FB, 0x200D, 0x2640⟆ 🤦🏻‍♀ E4.0 woman facepalming: light skin tone";
## 1F926 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🤦🏼‍♀️ E4.0 woman facepalming: medium-light skin tone # emoji-test.txt line #930 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🤦🏼‍♀️ E4.0 woman facepalming: medium-light skin tone";
## 1F926 1F3FC 200D 2640                      ; minimally-qualified # 🤦🏼‍♀ E4.0 woman facepalming: medium-light skin tone # emoji-test.txt line #931 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FC, 0x200D, 0x2640⟆ 🤦🏼‍♀ E4.0 woman facepalming: medium-light skin tone";
## 1F926 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🤦🏽‍♀️ E4.0 woman facepalming: medium skin tone # emoji-test.txt line #932 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🤦🏽‍♀️ E4.0 woman facepalming: medium skin tone";
## 1F926 1F3FD 200D 2640                      ; minimally-qualified # 🤦🏽‍♀ E4.0 woman facepalming: medium skin tone # emoji-test.txt line #933 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FD, 0x200D, 0x2640⟆ 🤦🏽‍♀ E4.0 woman facepalming: medium skin tone";
## 1F926 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🤦🏾‍♀️ E4.0 woman facepalming: medium-dark skin tone # emoji-test.txt line #934 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🤦🏾‍♀️ E4.0 woman facepalming: medium-dark skin tone";
## 1F926 1F3FE 200D 2640                      ; minimally-qualified # 🤦🏾‍♀ E4.0 woman facepalming: medium-dark skin tone # emoji-test.txt line #935 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FE, 0x200D, 0x2640⟆ 🤦🏾‍♀ E4.0 woman facepalming: medium-dark skin tone";
## 1F926 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🤦🏿‍♀️ E4.0 woman facepalming: dark skin tone # emoji-test.txt line #936 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🤦🏿‍♀️ E4.0 woman facepalming: dark skin tone";
## 1F926 1F3FF 200D 2640                      ; minimally-qualified # 🤦🏿‍♀ E4.0 woman facepalming: dark skin tone # emoji-test.txt line #937 Emoji version 13.0
is Uni.new(0x1F926, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F926, 0x1F3FF, 0x200D, 0x2640⟆ 🤦🏿‍♀ E4.0 woman facepalming: dark skin tone";
## 1F937 1F3FB                                ; fully-qualified     # 🤷🏻 E3.0 person shrugging: light skin tone # emoji-test.txt line #939 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FB⟆ 🤷🏻 E3.0 person shrugging: light skin tone";
## 1F937 1F3FC                                ; fully-qualified     # 🤷🏼 E3.0 person shrugging: medium-light skin tone # emoji-test.txt line #940 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FC⟆ 🤷🏼 E3.0 person shrugging: medium-light skin tone";
## 1F937 1F3FD                                ; fully-qualified     # 🤷🏽 E3.0 person shrugging: medium skin tone # emoji-test.txt line #941 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FD⟆ 🤷🏽 E3.0 person shrugging: medium skin tone";
## 1F937 1F3FE                                ; fully-qualified     # 🤷🏾 E3.0 person shrugging: medium-dark skin tone # emoji-test.txt line #942 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FE⟆ 🤷🏾 E3.0 person shrugging: medium-dark skin tone";
## 1F937 1F3FF                                ; fully-qualified     # 🤷🏿 E3.0 person shrugging: dark skin tone # emoji-test.txt line #943 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FF⟆ 🤷🏿 E3.0 person shrugging: dark skin tone";
## 1F937 200D 2642 FE0F                       ; fully-qualified     # 🤷‍♂️ E4.0 man shrugging # emoji-test.txt line #944 Emoji version 13.0
is Uni.new(0x1F937, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x200D, 0x2642, 0xFE0F⟆ 🤷‍♂️ E4.0 man shrugging";
## 1F937 200D 2642                            ; minimally-qualified # 🤷‍♂ E4.0 man shrugging # emoji-test.txt line #945 Emoji version 13.0
is Uni.new(0x1F937, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F937, 0x200D, 0x2642⟆ 🤷‍♂ E4.0 man shrugging";
## 1F937 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🤷🏻‍♂️ E4.0 man shrugging: light skin tone # emoji-test.txt line #946 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🤷🏻‍♂️ E4.0 man shrugging: light skin tone";
## 1F937 1F3FB 200D 2642                      ; minimally-qualified # 🤷🏻‍♂ E4.0 man shrugging: light skin tone # emoji-test.txt line #947 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FB, 0x200D, 0x2642⟆ 🤷🏻‍♂ E4.0 man shrugging: light skin tone";
## 1F937 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🤷🏼‍♂️ E4.0 man shrugging: medium-light skin tone # emoji-test.txt line #948 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🤷🏼‍♂️ E4.0 man shrugging: medium-light skin tone";
## 1F937 1F3FC 200D 2642                      ; minimally-qualified # 🤷🏼‍♂ E4.0 man shrugging: medium-light skin tone # emoji-test.txt line #949 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FC, 0x200D, 0x2642⟆ 🤷🏼‍♂ E4.0 man shrugging: medium-light skin tone";
## 1F937 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🤷🏽‍♂️ E4.0 man shrugging: medium skin tone # emoji-test.txt line #950 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🤷🏽‍♂️ E4.0 man shrugging: medium skin tone";
## 1F937 1F3FD 200D 2642                      ; minimally-qualified # 🤷🏽‍♂ E4.0 man shrugging: medium skin tone # emoji-test.txt line #951 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FD, 0x200D, 0x2642⟆ 🤷🏽‍♂ E4.0 man shrugging: medium skin tone";
## 1F937 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🤷🏾‍♂️ E4.0 man shrugging: medium-dark skin tone # emoji-test.txt line #952 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🤷🏾‍♂️ E4.0 man shrugging: medium-dark skin tone";
## 1F937 1F3FE 200D 2642                      ; minimally-qualified # 🤷🏾‍♂ E4.0 man shrugging: medium-dark skin tone # emoji-test.txt line #953 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FE, 0x200D, 0x2642⟆ 🤷🏾‍♂ E4.0 man shrugging: medium-dark skin tone";
## 1F937 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🤷🏿‍♂️ E4.0 man shrugging: dark skin tone # emoji-test.txt line #954 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🤷🏿‍♂️ E4.0 man shrugging: dark skin tone";
## 1F937 1F3FF 200D 2642                      ; minimally-qualified # 🤷🏿‍♂ E4.0 man shrugging: dark skin tone # emoji-test.txt line #955 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FF, 0x200D, 0x2642⟆ 🤷🏿‍♂ E4.0 man shrugging: dark skin tone";
## 1F937 200D 2640 FE0F                       ; fully-qualified     # 🤷‍♀️ E4.0 woman shrugging # emoji-test.txt line #956 Emoji version 13.0
is Uni.new(0x1F937, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x200D, 0x2640, 0xFE0F⟆ 🤷‍♀️ E4.0 woman shrugging";
## 1F937 200D 2640                            ; minimally-qualified # 🤷‍♀ E4.0 woman shrugging # emoji-test.txt line #957 Emoji version 13.0
is Uni.new(0x1F937, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F937, 0x200D, 0x2640⟆ 🤷‍♀ E4.0 woman shrugging";
## 1F937 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🤷🏻‍♀️ E4.0 woman shrugging: light skin tone # emoji-test.txt line #958 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🤷🏻‍♀️ E4.0 woman shrugging: light skin tone";
## 1F937 1F3FB 200D 2640                      ; minimally-qualified # 🤷🏻‍♀ E4.0 woman shrugging: light skin tone # emoji-test.txt line #959 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FB, 0x200D, 0x2640⟆ 🤷🏻‍♀ E4.0 woman shrugging: light skin tone";
## 1F937 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🤷🏼‍♀️ E4.0 woman shrugging: medium-light skin tone # emoji-test.txt line #960 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🤷🏼‍♀️ E4.0 woman shrugging: medium-light skin tone";
## 1F937 1F3FC 200D 2640                      ; minimally-qualified # 🤷🏼‍♀ E4.0 woman shrugging: medium-light skin tone # emoji-test.txt line #961 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FC, 0x200D, 0x2640⟆ 🤷🏼‍♀ E4.0 woman shrugging: medium-light skin tone";
## 1F937 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🤷🏽‍♀️ E4.0 woman shrugging: medium skin tone # emoji-test.txt line #962 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🤷🏽‍♀️ E4.0 woman shrugging: medium skin tone";
## 1F937 1F3FD 200D 2640                      ; minimally-qualified # 🤷🏽‍♀ E4.0 woman shrugging: medium skin tone # emoji-test.txt line #963 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FD, 0x200D, 0x2640⟆ 🤷🏽‍♀ E4.0 woman shrugging: medium skin tone";
## 1F937 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🤷🏾‍♀️ E4.0 woman shrugging: medium-dark skin tone # emoji-test.txt line #964 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🤷🏾‍♀️ E4.0 woman shrugging: medium-dark skin tone";
## 1F937 1F3FE 200D 2640                      ; minimally-qualified # 🤷🏾‍♀ E4.0 woman shrugging: medium-dark skin tone # emoji-test.txt line #965 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FE, 0x200D, 0x2640⟆ 🤷🏾‍♀ E4.0 woman shrugging: medium-dark skin tone";
## 1F937 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🤷🏿‍♀️ E4.0 woman shrugging: dark skin tone # emoji-test.txt line #966 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🤷🏿‍♀️ E4.0 woman shrugging: dark skin tone";
## 1F937 1F3FF 200D 2640                      ; minimally-qualified # 🤷🏿‍♀ E4.0 woman shrugging: dark skin tone # emoji-test.txt line #967 Emoji version 13.0
is Uni.new(0x1F937, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F937, 0x1F3FF, 0x200D, 0x2640⟆ 🤷🏿‍♀ E4.0 woman shrugging: dark skin tone";
## 1F9D1 200D 2695 FE0F                       ; fully-qualified     # 🧑‍⚕️ E12.1 health worker # emoji-test.txt line #970 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x2695, 0xFE0F⟆ 🧑‍⚕️ E12.1 health worker";
## 1F9D1 200D 2695                            ; minimally-qualified # 🧑‍⚕ E12.1 health worker # emoji-test.txt line #971 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x2695⟆ 🧑‍⚕ E12.1 health worker";
## 1F9D1 1F3FB 200D 2695 FE0F                 ; fully-qualified     # 🧑🏻‍⚕️ E12.1 health worker: light skin tone # emoji-test.txt line #972 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x2695, 0xFE0F⟆ 🧑🏻‍⚕️ E12.1 health worker: light skin tone";
## 1F9D1 1F3FB 200D 2695                      ; minimally-qualified # 🧑🏻‍⚕ E12.1 health worker: light skin tone # emoji-test.txt line #973 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x2695⟆ 🧑🏻‍⚕ E12.1 health worker: light skin tone";
## 1F9D1 1F3FC 200D 2695 FE0F                 ; fully-qualified     # 🧑🏼‍⚕️ E12.1 health worker: medium-light skin tone # emoji-test.txt line #974 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x2695, 0xFE0F⟆ 🧑🏼‍⚕️ E12.1 health worker: medium-light skin tone";
## 1F9D1 1F3FC 200D 2695                      ; minimally-qualified # 🧑🏼‍⚕ E12.1 health worker: medium-light skin tone # emoji-test.txt line #975 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x2695⟆ 🧑🏼‍⚕ E12.1 health worker: medium-light skin tone";
## 1F9D1 1F3FD 200D 2695 FE0F                 ; fully-qualified     # 🧑🏽‍⚕️ E12.1 health worker: medium skin tone # emoji-test.txt line #976 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x2695, 0xFE0F⟆ 🧑🏽‍⚕️ E12.1 health worker: medium skin tone";
## 1F9D1 1F3FD 200D 2695                      ; minimally-qualified # 🧑🏽‍⚕ E12.1 health worker: medium skin tone # emoji-test.txt line #977 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x2695⟆ 🧑🏽‍⚕ E12.1 health worker: medium skin tone";
## 1F9D1 1F3FE 200D 2695 FE0F                 ; fully-qualified     # 🧑🏾‍⚕️ E12.1 health worker: medium-dark skin tone # emoji-test.txt line #978 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x2695, 0xFE0F⟆ 🧑🏾‍⚕️ E12.1 health worker: medium-dark skin tone";
## 1F9D1 1F3FE 200D 2695                      ; minimally-qualified # 🧑🏾‍⚕ E12.1 health worker: medium-dark skin tone # emoji-test.txt line #979 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x2695⟆ 🧑🏾‍⚕ E12.1 health worker: medium-dark skin tone";
## 1F9D1 1F3FF 200D 2695 FE0F                 ; fully-qualified     # 🧑🏿‍⚕️ E12.1 health worker: dark skin tone # emoji-test.txt line #980 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x2695, 0xFE0F⟆ 🧑🏿‍⚕️ E12.1 health worker: dark skin tone";
## 1F9D1 1F3FF 200D 2695                      ; minimally-qualified # 🧑🏿‍⚕ E12.1 health worker: dark skin tone # emoji-test.txt line #981 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x2695⟆ 🧑🏿‍⚕ E12.1 health worker: dark skin tone";
## 1F468 200D 2695 FE0F                       ; fully-qualified     # 👨‍⚕️ E4.0 man health worker # emoji-test.txt line #982 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x2695, 0xFE0F⟆ 👨‍⚕️ E4.0 man health worker";
## 1F468 200D 2695                            ; minimally-qualified # 👨‍⚕ E4.0 man health worker # emoji-test.txt line #983 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x2695⟆ 👨‍⚕ E4.0 man health worker";
## 1F468 1F3FB 200D 2695 FE0F                 ; fully-qualified     # 👨🏻‍⚕️ E4.0 man health worker: light skin tone # emoji-test.txt line #984 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x2695, 0xFE0F⟆ 👨🏻‍⚕️ E4.0 man health worker: light skin tone";
## 1F468 1F3FB 200D 2695                      ; minimally-qualified # 👨🏻‍⚕ E4.0 man health worker: light skin tone # emoji-test.txt line #985 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x2695⟆ 👨🏻‍⚕ E4.0 man health worker: light skin tone";
## 1F468 1F3FC 200D 2695 FE0F                 ; fully-qualified     # 👨🏼‍⚕️ E4.0 man health worker: medium-light skin tone # emoji-test.txt line #986 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x2695, 0xFE0F⟆ 👨🏼‍⚕️ E4.0 man health worker: medium-light skin tone";
## 1F468 1F3FC 200D 2695                      ; minimally-qualified # 👨🏼‍⚕ E4.0 man health worker: medium-light skin tone # emoji-test.txt line #987 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x2695⟆ 👨🏼‍⚕ E4.0 man health worker: medium-light skin tone";
## 1F468 1F3FD 200D 2695 FE0F                 ; fully-qualified     # 👨🏽‍⚕️ E4.0 man health worker: medium skin tone # emoji-test.txt line #988 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x2695, 0xFE0F⟆ 👨🏽‍⚕️ E4.0 man health worker: medium skin tone";
## 1F468 1F3FD 200D 2695                      ; minimally-qualified # 👨🏽‍⚕ E4.0 man health worker: medium skin tone # emoji-test.txt line #989 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x2695⟆ 👨🏽‍⚕ E4.0 man health worker: medium skin tone";
## 1F468 1F3FE 200D 2695 FE0F                 ; fully-qualified     # 👨🏾‍⚕️ E4.0 man health worker: medium-dark skin tone # emoji-test.txt line #990 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x2695, 0xFE0F⟆ 👨🏾‍⚕️ E4.0 man health worker: medium-dark skin tone";
## 1F468 1F3FE 200D 2695                      ; minimally-qualified # 👨🏾‍⚕ E4.0 man health worker: medium-dark skin tone # emoji-test.txt line #991 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x2695⟆ 👨🏾‍⚕ E4.0 man health worker: medium-dark skin tone";
## 1F468 1F3FF 200D 2695 FE0F                 ; fully-qualified     # 👨🏿‍⚕️ E4.0 man health worker: dark skin tone # emoji-test.txt line #992 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x2695, 0xFE0F⟆ 👨🏿‍⚕️ E4.0 man health worker: dark skin tone";
## 1F468 1F3FF 200D 2695                      ; minimally-qualified # 👨🏿‍⚕ E4.0 man health worker: dark skin tone # emoji-test.txt line #993 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x2695⟆ 👨🏿‍⚕ E4.0 man health worker: dark skin tone";
## 1F469 200D 2695 FE0F                       ; fully-qualified     # 👩‍⚕️ E4.0 woman health worker # emoji-test.txt line #994 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2695, 0xFE0F⟆ 👩‍⚕️ E4.0 woman health worker";
## 1F469 200D 2695                            ; minimally-qualified # 👩‍⚕ E4.0 woman health worker # emoji-test.txt line #995 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2695⟆ 👩‍⚕ E4.0 woman health worker";
## 1F469 1F3FB 200D 2695 FE0F                 ; fully-qualified     # 👩🏻‍⚕️ E4.0 woman health worker: light skin tone # emoji-test.txt line #996 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x2695, 0xFE0F⟆ 👩🏻‍⚕️ E4.0 woman health worker: light skin tone";
## 1F469 1F3FB 200D 2695                      ; minimally-qualified # 👩🏻‍⚕ E4.0 woman health worker: light skin tone # emoji-test.txt line #997 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x2695⟆ 👩🏻‍⚕ E4.0 woman health worker: light skin tone";
## 1F469 1F3FC 200D 2695 FE0F                 ; fully-qualified     # 👩🏼‍⚕️ E4.0 woman health worker: medium-light skin tone # emoji-test.txt line #998 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x2695, 0xFE0F⟆ 👩🏼‍⚕️ E4.0 woman health worker: medium-light skin tone";
## 1F469 1F3FC 200D 2695                      ; minimally-qualified # 👩🏼‍⚕ E4.0 woman health worker: medium-light skin tone # emoji-test.txt line #999 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x2695⟆ 👩🏼‍⚕ E4.0 woman health worker: medium-light skin tone";
## 1F469 1F3FD 200D 2695 FE0F                 ; fully-qualified     # 👩🏽‍⚕️ E4.0 woman health worker: medium skin tone # emoji-test.txt line #1000 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x2695, 0xFE0F⟆ 👩🏽‍⚕️ E4.0 woman health worker: medium skin tone";
## 1F469 1F3FD 200D 2695                      ; minimally-qualified # 👩🏽‍⚕ E4.0 woman health worker: medium skin tone # emoji-test.txt line #1001 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x2695⟆ 👩🏽‍⚕ E4.0 woman health worker: medium skin tone";
## 1F469 1F3FE 200D 2695 FE0F                 ; fully-qualified     # 👩🏾‍⚕️ E4.0 woman health worker: medium-dark skin tone # emoji-test.txt line #1002 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x2695, 0xFE0F⟆ 👩🏾‍⚕️ E4.0 woman health worker: medium-dark skin tone";
## 1F469 1F3FE 200D 2695                      ; minimally-qualified # 👩🏾‍⚕ E4.0 woman health worker: medium-dark skin tone # emoji-test.txt line #1003 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x2695⟆ 👩🏾‍⚕ E4.0 woman health worker: medium-dark skin tone";
## 1F469 1F3FF 200D 2695 FE0F                 ; fully-qualified     # 👩🏿‍⚕️ E4.0 woman health worker: dark skin tone # emoji-test.txt line #1004 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x2695, 0xFE0F⟆ 👩🏿‍⚕️ E4.0 woman health worker: dark skin tone";
## 1F469 1F3FF 200D 2695                      ; minimally-qualified # 👩🏿‍⚕ E4.0 woman health worker: dark skin tone # emoji-test.txt line #1005 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x2695).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x2695⟆ 👩🏿‍⚕ E4.0 woman health worker: dark skin tone";
## 1F9D1 200D 1F393                           ; fully-qualified     # 🧑‍🎓 E12.1 student # emoji-test.txt line #1006 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F393⟆ 🧑‍🎓 E12.1 student";
## 1F9D1 1F3FB 200D 1F393                     ; fully-qualified     # 🧑🏻‍🎓 E12.1 student: light skin tone # emoji-test.txt line #1007 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F393⟆ 🧑🏻‍🎓 E12.1 student: light skin tone";
## 1F9D1 1F3FC 200D 1F393                     ; fully-qualified     # 🧑🏼‍🎓 E12.1 student: medium-light skin tone # emoji-test.txt line #1008 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F393⟆ 🧑🏼‍🎓 E12.1 student: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F393                     ; fully-qualified     # 🧑🏽‍🎓 E12.1 student: medium skin tone # emoji-test.txt line #1009 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F393⟆ 🧑🏽‍🎓 E12.1 student: medium skin tone";
## 1F9D1 1F3FE 200D 1F393                     ; fully-qualified     # 🧑🏾‍🎓 E12.1 student: medium-dark skin tone # emoji-test.txt line #1010 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F393⟆ 🧑🏾‍🎓 E12.1 student: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F393                     ; fully-qualified     # 🧑🏿‍🎓 E12.1 student: dark skin tone # emoji-test.txt line #1011 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F393⟆ 🧑🏿‍🎓 E12.1 student: dark skin tone";
## 1F468 200D 1F393                           ; fully-qualified     # 👨‍🎓 E4.0 man student # emoji-test.txt line #1012 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F393⟆ 👨‍🎓 E4.0 man student";
## 1F468 1F3FB 200D 1F393                     ; fully-qualified     # 👨🏻‍🎓 E4.0 man student: light skin tone # emoji-test.txt line #1013 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F393⟆ 👨🏻‍🎓 E4.0 man student: light skin tone";
## 1F468 1F3FC 200D 1F393                     ; fully-qualified     # 👨🏼‍🎓 E4.0 man student: medium-light skin tone # emoji-test.txt line #1014 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F393⟆ 👨🏼‍🎓 E4.0 man student: medium-light skin tone";
## 1F468 1F3FD 200D 1F393                     ; fully-qualified     # 👨🏽‍🎓 E4.0 man student: medium skin tone # emoji-test.txt line #1015 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F393⟆ 👨🏽‍🎓 E4.0 man student: medium skin tone";
## 1F468 1F3FE 200D 1F393                     ; fully-qualified     # 👨🏾‍🎓 E4.0 man student: medium-dark skin tone # emoji-test.txt line #1016 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F393⟆ 👨🏾‍🎓 E4.0 man student: medium-dark skin tone";
## 1F468 1F3FF 200D 1F393                     ; fully-qualified     # 👨🏿‍🎓 E4.0 man student: dark skin tone # emoji-test.txt line #1017 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F393⟆ 👨🏿‍🎓 E4.0 man student: dark skin tone";
## 1F469 200D 1F393                           ; fully-qualified     # 👩‍🎓 E4.0 woman student # emoji-test.txt line #1018 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F393⟆ 👩‍🎓 E4.0 woman student";
## 1F469 1F3FB 200D 1F393                     ; fully-qualified     # 👩🏻‍🎓 E4.0 woman student: light skin tone # emoji-test.txt line #1019 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F393⟆ 👩🏻‍🎓 E4.0 woman student: light skin tone";
## 1F469 1F3FC 200D 1F393                     ; fully-qualified     # 👩🏼‍🎓 E4.0 woman student: medium-light skin tone # emoji-test.txt line #1020 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F393⟆ 👩🏼‍🎓 E4.0 woman student: medium-light skin tone";
## 1F469 1F3FD 200D 1F393                     ; fully-qualified     # 👩🏽‍🎓 E4.0 woman student: medium skin tone # emoji-test.txt line #1021 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F393⟆ 👩🏽‍🎓 E4.0 woman student: medium skin tone";
## 1F469 1F3FE 200D 1F393                     ; fully-qualified     # 👩🏾‍🎓 E4.0 woman student: medium-dark skin tone # emoji-test.txt line #1022 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F393⟆ 👩🏾‍🎓 E4.0 woman student: medium-dark skin tone";
## 1F469 1F3FF 200D 1F393                     ; fully-qualified     # 👩🏿‍🎓 E4.0 woman student: dark skin tone # emoji-test.txt line #1023 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F393).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F393⟆ 👩🏿‍🎓 E4.0 woman student: dark skin tone";
## 1F9D1 200D 1F3EB                           ; fully-qualified     # 🧑‍🏫 E12.1 teacher # emoji-test.txt line #1024 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F3EB⟆ 🧑‍🏫 E12.1 teacher";
## 1F9D1 1F3FB 200D 1F3EB                     ; fully-qualified     # 🧑🏻‍🏫 E12.1 teacher: light skin tone # emoji-test.txt line #1025 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F3EB⟆ 🧑🏻‍🏫 E12.1 teacher: light skin tone";
## 1F9D1 1F3FC 200D 1F3EB                     ; fully-qualified     # 🧑🏼‍🏫 E12.1 teacher: medium-light skin tone # emoji-test.txt line #1026 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F3EB⟆ 🧑🏼‍🏫 E12.1 teacher: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F3EB                     ; fully-qualified     # 🧑🏽‍🏫 E12.1 teacher: medium skin tone # emoji-test.txt line #1027 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F3EB⟆ 🧑🏽‍🏫 E12.1 teacher: medium skin tone";
## 1F9D1 1F3FE 200D 1F3EB                     ; fully-qualified     # 🧑🏾‍🏫 E12.1 teacher: medium-dark skin tone # emoji-test.txt line #1028 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F3EB⟆ 🧑🏾‍🏫 E12.1 teacher: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F3EB                     ; fully-qualified     # 🧑🏿‍🏫 E12.1 teacher: dark skin tone # emoji-test.txt line #1029 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F3EB⟆ 🧑🏿‍🏫 E12.1 teacher: dark skin tone";
## 1F468 200D 1F3EB                           ; fully-qualified     # 👨‍🏫 E4.0 man teacher # emoji-test.txt line #1030 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F3EB⟆ 👨‍🏫 E4.0 man teacher";
## 1F468 1F3FB 200D 1F3EB                     ; fully-qualified     # 👨🏻‍🏫 E4.0 man teacher: light skin tone # emoji-test.txt line #1031 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F3EB⟆ 👨🏻‍🏫 E4.0 man teacher: light skin tone";
## 1F468 1F3FC 200D 1F3EB                     ; fully-qualified     # 👨🏼‍🏫 E4.0 man teacher: medium-light skin tone # emoji-test.txt line #1032 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F3EB⟆ 👨🏼‍🏫 E4.0 man teacher: medium-light skin tone";
## 1F468 1F3FD 200D 1F3EB                     ; fully-qualified     # 👨🏽‍🏫 E4.0 man teacher: medium skin tone # emoji-test.txt line #1033 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F3EB⟆ 👨🏽‍🏫 E4.0 man teacher: medium skin tone";
## 1F468 1F3FE 200D 1F3EB                     ; fully-qualified     # 👨🏾‍🏫 E4.0 man teacher: medium-dark skin tone # emoji-test.txt line #1034 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F3EB⟆ 👨🏾‍🏫 E4.0 man teacher: medium-dark skin tone";
## 1F468 1F3FF 200D 1F3EB                     ; fully-qualified     # 👨🏿‍🏫 E4.0 man teacher: dark skin tone # emoji-test.txt line #1035 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F3EB⟆ 👨🏿‍🏫 E4.0 man teacher: dark skin tone";
## 1F469 200D 1F3EB                           ; fully-qualified     # 👩‍🏫 E4.0 woman teacher # emoji-test.txt line #1036 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F3EB⟆ 👩‍🏫 E4.0 woman teacher";
## 1F469 1F3FB 200D 1F3EB                     ; fully-qualified     # 👩🏻‍🏫 E4.0 woman teacher: light skin tone # emoji-test.txt line #1037 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F3EB⟆ 👩🏻‍🏫 E4.0 woman teacher: light skin tone";
## 1F469 1F3FC 200D 1F3EB                     ; fully-qualified     # 👩🏼‍🏫 E4.0 woman teacher: medium-light skin tone # emoji-test.txt line #1038 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F3EB⟆ 👩🏼‍🏫 E4.0 woman teacher: medium-light skin tone";
## 1F469 1F3FD 200D 1F3EB                     ; fully-qualified     # 👩🏽‍🏫 E4.0 woman teacher: medium skin tone # emoji-test.txt line #1039 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F3EB⟆ 👩🏽‍🏫 E4.0 woman teacher: medium skin tone";
## 1F469 1F3FE 200D 1F3EB                     ; fully-qualified     # 👩🏾‍🏫 E4.0 woman teacher: medium-dark skin tone # emoji-test.txt line #1040 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F3EB⟆ 👩🏾‍🏫 E4.0 woman teacher: medium-dark skin tone";
## 1F469 1F3FF 200D 1F3EB                     ; fully-qualified     # 👩🏿‍🏫 E4.0 woman teacher: dark skin tone # emoji-test.txt line #1041 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F3EB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F3EB⟆ 👩🏿‍🏫 E4.0 woman teacher: dark skin tone";
## 1F9D1 200D 2696 FE0F                       ; fully-qualified     # 🧑‍⚖️ E12.1 judge # emoji-test.txt line #1042 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x2696, 0xFE0F⟆ 🧑‍⚖️ E12.1 judge";
## 1F9D1 200D 2696                            ; minimally-qualified # 🧑‍⚖ E12.1 judge # emoji-test.txt line #1043 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x2696⟆ 🧑‍⚖ E12.1 judge";
## 1F9D1 1F3FB 200D 2696 FE0F                 ; fully-qualified     # 🧑🏻‍⚖️ E12.1 judge: light skin tone # emoji-test.txt line #1044 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x2696, 0xFE0F⟆ 🧑🏻‍⚖️ E12.1 judge: light skin tone";
## 1F9D1 1F3FB 200D 2696                      ; minimally-qualified # 🧑🏻‍⚖ E12.1 judge: light skin tone # emoji-test.txt line #1045 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x2696⟆ 🧑🏻‍⚖ E12.1 judge: light skin tone";
## 1F9D1 1F3FC 200D 2696 FE0F                 ; fully-qualified     # 🧑🏼‍⚖️ E12.1 judge: medium-light skin tone # emoji-test.txt line #1046 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x2696, 0xFE0F⟆ 🧑🏼‍⚖️ E12.1 judge: medium-light skin tone";
## 1F9D1 1F3FC 200D 2696                      ; minimally-qualified # 🧑🏼‍⚖ E12.1 judge: medium-light skin tone # emoji-test.txt line #1047 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x2696⟆ 🧑🏼‍⚖ E12.1 judge: medium-light skin tone";
## 1F9D1 1F3FD 200D 2696 FE0F                 ; fully-qualified     # 🧑🏽‍⚖️ E12.1 judge: medium skin tone # emoji-test.txt line #1048 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x2696, 0xFE0F⟆ 🧑🏽‍⚖️ E12.1 judge: medium skin tone";
## 1F9D1 1F3FD 200D 2696                      ; minimally-qualified # 🧑🏽‍⚖ E12.1 judge: medium skin tone # emoji-test.txt line #1049 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x2696⟆ 🧑🏽‍⚖ E12.1 judge: medium skin tone";
## 1F9D1 1F3FE 200D 2696 FE0F                 ; fully-qualified     # 🧑🏾‍⚖️ E12.1 judge: medium-dark skin tone # emoji-test.txt line #1050 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x2696, 0xFE0F⟆ 🧑🏾‍⚖️ E12.1 judge: medium-dark skin tone";
## 1F9D1 1F3FE 200D 2696                      ; minimally-qualified # 🧑🏾‍⚖ E12.1 judge: medium-dark skin tone # emoji-test.txt line #1051 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x2696⟆ 🧑🏾‍⚖ E12.1 judge: medium-dark skin tone";
## 1F9D1 1F3FF 200D 2696 FE0F                 ; fully-qualified     # 🧑🏿‍⚖️ E12.1 judge: dark skin tone # emoji-test.txt line #1052 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x2696, 0xFE0F⟆ 🧑🏿‍⚖️ E12.1 judge: dark skin tone";
## 1F9D1 1F3FF 200D 2696                      ; minimally-qualified # 🧑🏿‍⚖ E12.1 judge: dark skin tone # emoji-test.txt line #1053 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x2696⟆ 🧑🏿‍⚖ E12.1 judge: dark skin tone";
## 1F468 200D 2696 FE0F                       ; fully-qualified     # 👨‍⚖️ E4.0 man judge # emoji-test.txt line #1054 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x2696, 0xFE0F⟆ 👨‍⚖️ E4.0 man judge";
## 1F468 200D 2696                            ; minimally-qualified # 👨‍⚖ E4.0 man judge # emoji-test.txt line #1055 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x2696⟆ 👨‍⚖ E4.0 man judge";
## 1F468 1F3FB 200D 2696 FE0F                 ; fully-qualified     # 👨🏻‍⚖️ E4.0 man judge: light skin tone # emoji-test.txt line #1056 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x2696, 0xFE0F⟆ 👨🏻‍⚖️ E4.0 man judge: light skin tone";
## 1F468 1F3FB 200D 2696                      ; minimally-qualified # 👨🏻‍⚖ E4.0 man judge: light skin tone # emoji-test.txt line #1057 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x2696⟆ 👨🏻‍⚖ E4.0 man judge: light skin tone";
## 1F468 1F3FC 200D 2696 FE0F                 ; fully-qualified     # 👨🏼‍⚖️ E4.0 man judge: medium-light skin tone # emoji-test.txt line #1058 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x2696, 0xFE0F⟆ 👨🏼‍⚖️ E4.0 man judge: medium-light skin tone";
## 1F468 1F3FC 200D 2696                      ; minimally-qualified # 👨🏼‍⚖ E4.0 man judge: medium-light skin tone # emoji-test.txt line #1059 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x2696⟆ 👨🏼‍⚖ E4.0 man judge: medium-light skin tone";
## 1F468 1F3FD 200D 2696 FE0F                 ; fully-qualified     # 👨🏽‍⚖️ E4.0 man judge: medium skin tone # emoji-test.txt line #1060 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x2696, 0xFE0F⟆ 👨🏽‍⚖️ E4.0 man judge: medium skin tone";
## 1F468 1F3FD 200D 2696                      ; minimally-qualified # 👨🏽‍⚖ E4.0 man judge: medium skin tone # emoji-test.txt line #1061 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x2696⟆ 👨🏽‍⚖ E4.0 man judge: medium skin tone";
## 1F468 1F3FE 200D 2696 FE0F                 ; fully-qualified     # 👨🏾‍⚖️ E4.0 man judge: medium-dark skin tone # emoji-test.txt line #1062 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x2696, 0xFE0F⟆ 👨🏾‍⚖️ E4.0 man judge: medium-dark skin tone";
## 1F468 1F3FE 200D 2696                      ; minimally-qualified # 👨🏾‍⚖ E4.0 man judge: medium-dark skin tone # emoji-test.txt line #1063 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x2696⟆ 👨🏾‍⚖ E4.0 man judge: medium-dark skin tone";
## 1F468 1F3FF 200D 2696 FE0F                 ; fully-qualified     # 👨🏿‍⚖️ E4.0 man judge: dark skin tone # emoji-test.txt line #1064 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x2696, 0xFE0F⟆ 👨🏿‍⚖️ E4.0 man judge: dark skin tone";
## 1F468 1F3FF 200D 2696                      ; minimally-qualified # 👨🏿‍⚖ E4.0 man judge: dark skin tone # emoji-test.txt line #1065 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x2696⟆ 👨🏿‍⚖ E4.0 man judge: dark skin tone";
## 1F469 200D 2696 FE0F                       ; fully-qualified     # 👩‍⚖️ E4.0 woman judge # emoji-test.txt line #1066 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2696, 0xFE0F⟆ 👩‍⚖️ E4.0 woman judge";
## 1F469 200D 2696                            ; minimally-qualified # 👩‍⚖ E4.0 woman judge # emoji-test.txt line #1067 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2696⟆ 👩‍⚖ E4.0 woman judge";
## 1F469 1F3FB 200D 2696 FE0F                 ; fully-qualified     # 👩🏻‍⚖️ E4.0 woman judge: light skin tone # emoji-test.txt line #1068 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x2696, 0xFE0F⟆ 👩🏻‍⚖️ E4.0 woman judge: light skin tone";
## 1F469 1F3FB 200D 2696                      ; minimally-qualified # 👩🏻‍⚖ E4.0 woman judge: light skin tone # emoji-test.txt line #1069 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x2696⟆ 👩🏻‍⚖ E4.0 woman judge: light skin tone";
## 1F469 1F3FC 200D 2696 FE0F                 ; fully-qualified     # 👩🏼‍⚖️ E4.0 woman judge: medium-light skin tone # emoji-test.txt line #1070 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x2696, 0xFE0F⟆ 👩🏼‍⚖️ E4.0 woman judge: medium-light skin tone";
## 1F469 1F3FC 200D 2696                      ; minimally-qualified # 👩🏼‍⚖ E4.0 woman judge: medium-light skin tone # emoji-test.txt line #1071 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x2696⟆ 👩🏼‍⚖ E4.0 woman judge: medium-light skin tone";
## 1F469 1F3FD 200D 2696 FE0F                 ; fully-qualified     # 👩🏽‍⚖️ E4.0 woman judge: medium skin tone # emoji-test.txt line #1072 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x2696, 0xFE0F⟆ 👩🏽‍⚖️ E4.0 woman judge: medium skin tone";
## 1F469 1F3FD 200D 2696                      ; minimally-qualified # 👩🏽‍⚖ E4.0 woman judge: medium skin tone # emoji-test.txt line #1073 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x2696⟆ 👩🏽‍⚖ E4.0 woman judge: medium skin tone";
## 1F469 1F3FE 200D 2696 FE0F                 ; fully-qualified     # 👩🏾‍⚖️ E4.0 woman judge: medium-dark skin tone # emoji-test.txt line #1074 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x2696, 0xFE0F⟆ 👩🏾‍⚖️ E4.0 woman judge: medium-dark skin tone";
## 1F469 1F3FE 200D 2696                      ; minimally-qualified # 👩🏾‍⚖ E4.0 woman judge: medium-dark skin tone # emoji-test.txt line #1075 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x2696⟆ 👩🏾‍⚖ E4.0 woman judge: medium-dark skin tone";
## 1F469 1F3FF 200D 2696 FE0F                 ; fully-qualified     # 👩🏿‍⚖️ E4.0 woman judge: dark skin tone # emoji-test.txt line #1076 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x2696, 0xFE0F⟆ 👩🏿‍⚖️ E4.0 woman judge: dark skin tone";
## 1F469 1F3FF 200D 2696                      ; minimally-qualified # 👩🏿‍⚖ E4.0 woman judge: dark skin tone # emoji-test.txt line #1077 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x2696).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x2696⟆ 👩🏿‍⚖ E4.0 woman judge: dark skin tone";
## 1F9D1 200D 1F33E                           ; fully-qualified     # 🧑‍🌾 E12.1 farmer # emoji-test.txt line #1078 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F33E⟆ 🧑‍🌾 E12.1 farmer";
## 1F9D1 1F3FB 200D 1F33E                     ; fully-qualified     # 🧑🏻‍🌾 E12.1 farmer: light skin tone # emoji-test.txt line #1079 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F33E⟆ 🧑🏻‍🌾 E12.1 farmer: light skin tone";
## 1F9D1 1F3FC 200D 1F33E                     ; fully-qualified     # 🧑🏼‍🌾 E12.1 farmer: medium-light skin tone # emoji-test.txt line #1080 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F33E⟆ 🧑🏼‍🌾 E12.1 farmer: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F33E                     ; fully-qualified     # 🧑🏽‍🌾 E12.1 farmer: medium skin tone # emoji-test.txt line #1081 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F33E⟆ 🧑🏽‍🌾 E12.1 farmer: medium skin tone";
## 1F9D1 1F3FE 200D 1F33E                     ; fully-qualified     # 🧑🏾‍🌾 E12.1 farmer: medium-dark skin tone # emoji-test.txt line #1082 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F33E⟆ 🧑🏾‍🌾 E12.1 farmer: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F33E                     ; fully-qualified     # 🧑🏿‍🌾 E12.1 farmer: dark skin tone # emoji-test.txt line #1083 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F33E⟆ 🧑🏿‍🌾 E12.1 farmer: dark skin tone";
## 1F468 200D 1F33E                           ; fully-qualified     # 👨‍🌾 E4.0 man farmer # emoji-test.txt line #1084 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F33E⟆ 👨‍🌾 E4.0 man farmer";
## 1F468 1F3FB 200D 1F33E                     ; fully-qualified     # 👨🏻‍🌾 E4.0 man farmer: light skin tone # emoji-test.txt line #1085 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F33E⟆ 👨🏻‍🌾 E4.0 man farmer: light skin tone";
## 1F468 1F3FC 200D 1F33E                     ; fully-qualified     # 👨🏼‍🌾 E4.0 man farmer: medium-light skin tone # emoji-test.txt line #1086 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F33E⟆ 👨🏼‍🌾 E4.0 man farmer: medium-light skin tone";
## 1F468 1F3FD 200D 1F33E                     ; fully-qualified     # 👨🏽‍🌾 E4.0 man farmer: medium skin tone # emoji-test.txt line #1087 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F33E⟆ 👨🏽‍🌾 E4.0 man farmer: medium skin tone";
## 1F468 1F3FE 200D 1F33E                     ; fully-qualified     # 👨🏾‍🌾 E4.0 man farmer: medium-dark skin tone # emoji-test.txt line #1088 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F33E⟆ 👨🏾‍🌾 E4.0 man farmer: medium-dark skin tone";
## 1F468 1F3FF 200D 1F33E                     ; fully-qualified     # 👨🏿‍🌾 E4.0 man farmer: dark skin tone # emoji-test.txt line #1089 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F33E⟆ 👨🏿‍🌾 E4.0 man farmer: dark skin tone";
## 1F469 200D 1F33E                           ; fully-qualified     # 👩‍🌾 E4.0 woman farmer # emoji-test.txt line #1090 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F33E⟆ 👩‍🌾 E4.0 woman farmer";
## 1F469 1F3FB 200D 1F33E                     ; fully-qualified     # 👩🏻‍🌾 E4.0 woman farmer: light skin tone # emoji-test.txt line #1091 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F33E⟆ 👩🏻‍🌾 E4.0 woman farmer: light skin tone";
## 1F469 1F3FC 200D 1F33E                     ; fully-qualified     # 👩🏼‍🌾 E4.0 woman farmer: medium-light skin tone # emoji-test.txt line #1092 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F33E⟆ 👩🏼‍🌾 E4.0 woman farmer: medium-light skin tone";
## 1F469 1F3FD 200D 1F33E                     ; fully-qualified     # 👩🏽‍🌾 E4.0 woman farmer: medium skin tone # emoji-test.txt line #1093 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F33E⟆ 👩🏽‍🌾 E4.0 woman farmer: medium skin tone";
## 1F469 1F3FE 200D 1F33E                     ; fully-qualified     # 👩🏾‍🌾 E4.0 woman farmer: medium-dark skin tone # emoji-test.txt line #1094 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F33E⟆ 👩🏾‍🌾 E4.0 woman farmer: medium-dark skin tone";
## 1F469 1F3FF 200D 1F33E                     ; fully-qualified     # 👩🏿‍🌾 E4.0 woman farmer: dark skin tone # emoji-test.txt line #1095 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F33E).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F33E⟆ 👩🏿‍🌾 E4.0 woman farmer: dark skin tone";
## 1F9D1 200D 1F373                           ; fully-qualified     # 🧑‍🍳 E12.1 cook # emoji-test.txt line #1096 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F373⟆ 🧑‍🍳 E12.1 cook";
## 1F9D1 1F3FB 200D 1F373                     ; fully-qualified     # 🧑🏻‍🍳 E12.1 cook: light skin tone # emoji-test.txt line #1097 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F373⟆ 🧑🏻‍🍳 E12.1 cook: light skin tone";
## 1F9D1 1F3FC 200D 1F373                     ; fully-qualified     # 🧑🏼‍🍳 E12.1 cook: medium-light skin tone # emoji-test.txt line #1098 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F373⟆ 🧑🏼‍🍳 E12.1 cook: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F373                     ; fully-qualified     # 🧑🏽‍🍳 E12.1 cook: medium skin tone # emoji-test.txt line #1099 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F373⟆ 🧑🏽‍🍳 E12.1 cook: medium skin tone";
## 1F9D1 1F3FE 200D 1F373                     ; fully-qualified     # 🧑🏾‍🍳 E12.1 cook: medium-dark skin tone # emoji-test.txt line #1100 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F373⟆ 🧑🏾‍🍳 E12.1 cook: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F373                     ; fully-qualified     # 🧑🏿‍🍳 E12.1 cook: dark skin tone # emoji-test.txt line #1101 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F373⟆ 🧑🏿‍🍳 E12.1 cook: dark skin tone";
## 1F468 200D 1F373                           ; fully-qualified     # 👨‍🍳 E4.0 man cook # emoji-test.txt line #1102 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F373⟆ 👨‍🍳 E4.0 man cook";
## 1F468 1F3FB 200D 1F373                     ; fully-qualified     # 👨🏻‍🍳 E4.0 man cook: light skin tone # emoji-test.txt line #1103 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F373⟆ 👨🏻‍🍳 E4.0 man cook: light skin tone";
## 1F468 1F3FC 200D 1F373                     ; fully-qualified     # 👨🏼‍🍳 E4.0 man cook: medium-light skin tone # emoji-test.txt line #1104 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F373⟆ 👨🏼‍🍳 E4.0 man cook: medium-light skin tone";
## 1F468 1F3FD 200D 1F373                     ; fully-qualified     # 👨🏽‍🍳 E4.0 man cook: medium skin tone # emoji-test.txt line #1105 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F373⟆ 👨🏽‍🍳 E4.0 man cook: medium skin tone";
## 1F468 1F3FE 200D 1F373                     ; fully-qualified     # 👨🏾‍🍳 E4.0 man cook: medium-dark skin tone # emoji-test.txt line #1106 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F373⟆ 👨🏾‍🍳 E4.0 man cook: medium-dark skin tone";
## 1F468 1F3FF 200D 1F373                     ; fully-qualified     # 👨🏿‍🍳 E4.0 man cook: dark skin tone # emoji-test.txt line #1107 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F373⟆ 👨🏿‍🍳 E4.0 man cook: dark skin tone";
## 1F469 200D 1F373                           ; fully-qualified     # 👩‍🍳 E4.0 woman cook # emoji-test.txt line #1108 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F373⟆ 👩‍🍳 E4.0 woman cook";
## 1F469 1F3FB 200D 1F373                     ; fully-qualified     # 👩🏻‍🍳 E4.0 woman cook: light skin tone # emoji-test.txt line #1109 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F373⟆ 👩🏻‍🍳 E4.0 woman cook: light skin tone";
## 1F469 1F3FC 200D 1F373                     ; fully-qualified     # 👩🏼‍🍳 E4.0 woman cook: medium-light skin tone # emoji-test.txt line #1110 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F373⟆ 👩🏼‍🍳 E4.0 woman cook: medium-light skin tone";
## 1F469 1F3FD 200D 1F373                     ; fully-qualified     # 👩🏽‍🍳 E4.0 woman cook: medium skin tone # emoji-test.txt line #1111 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F373⟆ 👩🏽‍🍳 E4.0 woman cook: medium skin tone";
## 1F469 1F3FE 200D 1F373                     ; fully-qualified     # 👩🏾‍🍳 E4.0 woman cook: medium-dark skin tone # emoji-test.txt line #1112 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F373⟆ 👩🏾‍🍳 E4.0 woman cook: medium-dark skin tone";
## 1F469 1F3FF 200D 1F373                     ; fully-qualified     # 👩🏿‍🍳 E4.0 woman cook: dark skin tone # emoji-test.txt line #1113 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F373).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F373⟆ 👩🏿‍🍳 E4.0 woman cook: dark skin tone";
## 1F9D1 200D 1F527                           ; fully-qualified     # 🧑‍🔧 E12.1 mechanic # emoji-test.txt line #1114 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F527⟆ 🧑‍🔧 E12.1 mechanic";
## 1F9D1 1F3FB 200D 1F527                     ; fully-qualified     # 🧑🏻‍🔧 E12.1 mechanic: light skin tone # emoji-test.txt line #1115 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F527⟆ 🧑🏻‍🔧 E12.1 mechanic: light skin tone";
## 1F9D1 1F3FC 200D 1F527                     ; fully-qualified     # 🧑🏼‍🔧 E12.1 mechanic: medium-light skin tone # emoji-test.txt line #1116 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F527⟆ 🧑🏼‍🔧 E12.1 mechanic: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F527                     ; fully-qualified     # 🧑🏽‍🔧 E12.1 mechanic: medium skin tone # emoji-test.txt line #1117 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F527⟆ 🧑🏽‍🔧 E12.1 mechanic: medium skin tone";
## 1F9D1 1F3FE 200D 1F527                     ; fully-qualified     # 🧑🏾‍🔧 E12.1 mechanic: medium-dark skin tone # emoji-test.txt line #1118 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F527⟆ 🧑🏾‍🔧 E12.1 mechanic: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F527                     ; fully-qualified     # 🧑🏿‍🔧 E12.1 mechanic: dark skin tone # emoji-test.txt line #1119 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F527⟆ 🧑🏿‍🔧 E12.1 mechanic: dark skin tone";
## 1F468 200D 1F527                           ; fully-qualified     # 👨‍🔧 E4.0 man mechanic # emoji-test.txt line #1120 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F527⟆ 👨‍🔧 E4.0 man mechanic";
## 1F468 1F3FB 200D 1F527                     ; fully-qualified     # 👨🏻‍🔧 E4.0 man mechanic: light skin tone # emoji-test.txt line #1121 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F527⟆ 👨🏻‍🔧 E4.0 man mechanic: light skin tone";
## 1F468 1F3FC 200D 1F527                     ; fully-qualified     # 👨🏼‍🔧 E4.0 man mechanic: medium-light skin tone # emoji-test.txt line #1122 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F527⟆ 👨🏼‍🔧 E4.0 man mechanic: medium-light skin tone";
## 1F468 1F3FD 200D 1F527                     ; fully-qualified     # 👨🏽‍🔧 E4.0 man mechanic: medium skin tone # emoji-test.txt line #1123 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F527⟆ 👨🏽‍🔧 E4.0 man mechanic: medium skin tone";
## 1F468 1F3FE 200D 1F527                     ; fully-qualified     # 👨🏾‍🔧 E4.0 man mechanic: medium-dark skin tone # emoji-test.txt line #1124 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F527⟆ 👨🏾‍🔧 E4.0 man mechanic: medium-dark skin tone";
## 1F468 1F3FF 200D 1F527                     ; fully-qualified     # 👨🏿‍🔧 E4.0 man mechanic: dark skin tone # emoji-test.txt line #1125 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F527⟆ 👨🏿‍🔧 E4.0 man mechanic: dark skin tone";
## 1F469 200D 1F527                           ; fully-qualified     # 👩‍🔧 E4.0 woman mechanic # emoji-test.txt line #1126 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F527⟆ 👩‍🔧 E4.0 woman mechanic";
## 1F469 1F3FB 200D 1F527                     ; fully-qualified     # 👩🏻‍🔧 E4.0 woman mechanic: light skin tone # emoji-test.txt line #1127 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F527⟆ 👩🏻‍🔧 E4.0 woman mechanic: light skin tone";
## 1F469 1F3FC 200D 1F527                     ; fully-qualified     # 👩🏼‍🔧 E4.0 woman mechanic: medium-light skin tone # emoji-test.txt line #1128 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F527⟆ 👩🏼‍🔧 E4.0 woman mechanic: medium-light skin tone";
## 1F469 1F3FD 200D 1F527                     ; fully-qualified     # 👩🏽‍🔧 E4.0 woman mechanic: medium skin tone # emoji-test.txt line #1129 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F527⟆ 👩🏽‍🔧 E4.0 woman mechanic: medium skin tone";
## 1F469 1F3FE 200D 1F527                     ; fully-qualified     # 👩🏾‍🔧 E4.0 woman mechanic: medium-dark skin tone # emoji-test.txt line #1130 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F527⟆ 👩🏾‍🔧 E4.0 woman mechanic: medium-dark skin tone";
## 1F469 1F3FF 200D 1F527                     ; fully-qualified     # 👩🏿‍🔧 E4.0 woman mechanic: dark skin tone # emoji-test.txt line #1131 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F527).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F527⟆ 👩🏿‍🔧 E4.0 woman mechanic: dark skin tone";
## 1F9D1 200D 1F3ED                           ; fully-qualified     # 🧑‍🏭 E12.1 factory worker # emoji-test.txt line #1132 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F3ED⟆ 🧑‍🏭 E12.1 factory worker";
## 1F9D1 1F3FB 200D 1F3ED                     ; fully-qualified     # 🧑🏻‍🏭 E12.1 factory worker: light skin tone # emoji-test.txt line #1133 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F3ED⟆ 🧑🏻‍🏭 E12.1 factory worker: light skin tone";
## 1F9D1 1F3FC 200D 1F3ED                     ; fully-qualified     # 🧑🏼‍🏭 E12.1 factory worker: medium-light skin tone # emoji-test.txt line #1134 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F3ED⟆ 🧑🏼‍🏭 E12.1 factory worker: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F3ED                     ; fully-qualified     # 🧑🏽‍🏭 E12.1 factory worker: medium skin tone # emoji-test.txt line #1135 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F3ED⟆ 🧑🏽‍🏭 E12.1 factory worker: medium skin tone";
## 1F9D1 1F3FE 200D 1F3ED                     ; fully-qualified     # 🧑🏾‍🏭 E12.1 factory worker: medium-dark skin tone # emoji-test.txt line #1136 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F3ED⟆ 🧑🏾‍🏭 E12.1 factory worker: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F3ED                     ; fully-qualified     # 🧑🏿‍🏭 E12.1 factory worker: dark skin tone # emoji-test.txt line #1137 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F3ED⟆ 🧑🏿‍🏭 E12.1 factory worker: dark skin tone";
## 1F468 200D 1F3ED                           ; fully-qualified     # 👨‍🏭 E4.0 man factory worker # emoji-test.txt line #1138 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F3ED⟆ 👨‍🏭 E4.0 man factory worker";
## 1F468 1F3FB 200D 1F3ED                     ; fully-qualified     # 👨🏻‍🏭 E4.0 man factory worker: light skin tone # emoji-test.txt line #1139 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F3ED⟆ 👨🏻‍🏭 E4.0 man factory worker: light skin tone";
## 1F468 1F3FC 200D 1F3ED                     ; fully-qualified     # 👨🏼‍🏭 E4.0 man factory worker: medium-light skin tone # emoji-test.txt line #1140 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F3ED⟆ 👨🏼‍🏭 E4.0 man factory worker: medium-light skin tone";
## 1F468 1F3FD 200D 1F3ED                     ; fully-qualified     # 👨🏽‍🏭 E4.0 man factory worker: medium skin tone # emoji-test.txt line #1141 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F3ED⟆ 👨🏽‍🏭 E4.0 man factory worker: medium skin tone";
## 1F468 1F3FE 200D 1F3ED                     ; fully-qualified     # 👨🏾‍🏭 E4.0 man factory worker: medium-dark skin tone # emoji-test.txt line #1142 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F3ED⟆ 👨🏾‍🏭 E4.0 man factory worker: medium-dark skin tone";
## 1F468 1F3FF 200D 1F3ED                     ; fully-qualified     # 👨🏿‍🏭 E4.0 man factory worker: dark skin tone # emoji-test.txt line #1143 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F3ED⟆ 👨🏿‍🏭 E4.0 man factory worker: dark skin tone";
## 1F469 200D 1F3ED                           ; fully-qualified     # 👩‍🏭 E4.0 woman factory worker # emoji-test.txt line #1144 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F3ED⟆ 👩‍🏭 E4.0 woman factory worker";
## 1F469 1F3FB 200D 1F3ED                     ; fully-qualified     # 👩🏻‍🏭 E4.0 woman factory worker: light skin tone # emoji-test.txt line #1145 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F3ED⟆ 👩🏻‍🏭 E4.0 woman factory worker: light skin tone";
## 1F469 1F3FC 200D 1F3ED                     ; fully-qualified     # 👩🏼‍🏭 E4.0 woman factory worker: medium-light skin tone # emoji-test.txt line #1146 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F3ED⟆ 👩🏼‍🏭 E4.0 woman factory worker: medium-light skin tone";
## 1F469 1F3FD 200D 1F3ED                     ; fully-qualified     # 👩🏽‍🏭 E4.0 woman factory worker: medium skin tone # emoji-test.txt line #1147 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F3ED⟆ 👩🏽‍🏭 E4.0 woman factory worker: medium skin tone";
## 1F469 1F3FE 200D 1F3ED                     ; fully-qualified     # 👩🏾‍🏭 E4.0 woman factory worker: medium-dark skin tone # emoji-test.txt line #1148 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F3ED⟆ 👩🏾‍🏭 E4.0 woman factory worker: medium-dark skin tone";
## 1F469 1F3FF 200D 1F3ED                     ; fully-qualified     # 👩🏿‍🏭 E4.0 woman factory worker: dark skin tone # emoji-test.txt line #1149 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F3ED).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F3ED⟆ 👩🏿‍🏭 E4.0 woman factory worker: dark skin tone";
## 1F9D1 200D 1F4BC                           ; fully-qualified     # 🧑‍💼 E12.1 office worker # emoji-test.txt line #1150 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F4BC⟆ 🧑‍💼 E12.1 office worker";
## 1F9D1 1F3FB 200D 1F4BC                     ; fully-qualified     # 🧑🏻‍💼 E12.1 office worker: light skin tone # emoji-test.txt line #1151 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F4BC⟆ 🧑🏻‍💼 E12.1 office worker: light skin tone";
## 1F9D1 1F3FC 200D 1F4BC                     ; fully-qualified     # 🧑🏼‍💼 E12.1 office worker: medium-light skin tone # emoji-test.txt line #1152 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F4BC⟆ 🧑🏼‍💼 E12.1 office worker: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F4BC                     ; fully-qualified     # 🧑🏽‍💼 E12.1 office worker: medium skin tone # emoji-test.txt line #1153 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F4BC⟆ 🧑🏽‍💼 E12.1 office worker: medium skin tone";
## 1F9D1 1F3FE 200D 1F4BC                     ; fully-qualified     # 🧑🏾‍💼 E12.1 office worker: medium-dark skin tone # emoji-test.txt line #1154 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F4BC⟆ 🧑🏾‍💼 E12.1 office worker: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F4BC                     ; fully-qualified     # 🧑🏿‍💼 E12.1 office worker: dark skin tone # emoji-test.txt line #1155 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F4BC⟆ 🧑🏿‍💼 E12.1 office worker: dark skin tone";
## 1F468 200D 1F4BC                           ; fully-qualified     # 👨‍💼 E4.0 man office worker # emoji-test.txt line #1156 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F4BC⟆ 👨‍💼 E4.0 man office worker";
## 1F468 1F3FB 200D 1F4BC                     ; fully-qualified     # 👨🏻‍💼 E4.0 man office worker: light skin tone # emoji-test.txt line #1157 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F4BC⟆ 👨🏻‍💼 E4.0 man office worker: light skin tone";
## 1F468 1F3FC 200D 1F4BC                     ; fully-qualified     # 👨🏼‍💼 E4.0 man office worker: medium-light skin tone # emoji-test.txt line #1158 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F4BC⟆ 👨🏼‍💼 E4.0 man office worker: medium-light skin tone";
## 1F468 1F3FD 200D 1F4BC                     ; fully-qualified     # 👨🏽‍💼 E4.0 man office worker: medium skin tone # emoji-test.txt line #1159 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F4BC⟆ 👨🏽‍💼 E4.0 man office worker: medium skin tone";
## 1F468 1F3FE 200D 1F4BC                     ; fully-qualified     # 👨🏾‍💼 E4.0 man office worker: medium-dark skin tone # emoji-test.txt line #1160 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F4BC⟆ 👨🏾‍💼 E4.0 man office worker: medium-dark skin tone";
## 1F468 1F3FF 200D 1F4BC                     ; fully-qualified     # 👨🏿‍💼 E4.0 man office worker: dark skin tone # emoji-test.txt line #1161 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F4BC⟆ 👨🏿‍💼 E4.0 man office worker: dark skin tone";
## 1F469 200D 1F4BC                           ; fully-qualified     # 👩‍💼 E4.0 woman office worker # emoji-test.txt line #1162 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F4BC⟆ 👩‍💼 E4.0 woman office worker";
## 1F469 1F3FB 200D 1F4BC                     ; fully-qualified     # 👩🏻‍💼 E4.0 woman office worker: light skin tone # emoji-test.txt line #1163 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F4BC⟆ 👩🏻‍💼 E4.0 woman office worker: light skin tone";
## 1F469 1F3FC 200D 1F4BC                     ; fully-qualified     # 👩🏼‍💼 E4.0 woman office worker: medium-light skin tone # emoji-test.txt line #1164 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F4BC⟆ 👩🏼‍💼 E4.0 woman office worker: medium-light skin tone";
## 1F469 1F3FD 200D 1F4BC                     ; fully-qualified     # 👩🏽‍💼 E4.0 woman office worker: medium skin tone # emoji-test.txt line #1165 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F4BC⟆ 👩🏽‍💼 E4.0 woman office worker: medium skin tone";
## 1F469 1F3FE 200D 1F4BC                     ; fully-qualified     # 👩🏾‍💼 E4.0 woman office worker: medium-dark skin tone # emoji-test.txt line #1166 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F4BC⟆ 👩🏾‍💼 E4.0 woman office worker: medium-dark skin tone";
## 1F469 1F3FF 200D 1F4BC                     ; fully-qualified     # 👩🏿‍💼 E4.0 woman office worker: dark skin tone # emoji-test.txt line #1167 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F4BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F4BC⟆ 👩🏿‍💼 E4.0 woman office worker: dark skin tone";
## 1F9D1 200D 1F52C                           ; fully-qualified     # 🧑‍🔬 E12.1 scientist # emoji-test.txt line #1168 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F52C⟆ 🧑‍🔬 E12.1 scientist";
## 1F9D1 1F3FB 200D 1F52C                     ; fully-qualified     # 🧑🏻‍🔬 E12.1 scientist: light skin tone # emoji-test.txt line #1169 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F52C⟆ 🧑🏻‍🔬 E12.1 scientist: light skin tone";
## 1F9D1 1F3FC 200D 1F52C                     ; fully-qualified     # 🧑🏼‍🔬 E12.1 scientist: medium-light skin tone # emoji-test.txt line #1170 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F52C⟆ 🧑🏼‍🔬 E12.1 scientist: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F52C                     ; fully-qualified     # 🧑🏽‍🔬 E12.1 scientist: medium skin tone # emoji-test.txt line #1171 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F52C⟆ 🧑🏽‍🔬 E12.1 scientist: medium skin tone";
## 1F9D1 1F3FE 200D 1F52C                     ; fully-qualified     # 🧑🏾‍🔬 E12.1 scientist: medium-dark skin tone # emoji-test.txt line #1172 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F52C⟆ 🧑🏾‍🔬 E12.1 scientist: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F52C                     ; fully-qualified     # 🧑🏿‍🔬 E12.1 scientist: dark skin tone # emoji-test.txt line #1173 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F52C⟆ 🧑🏿‍🔬 E12.1 scientist: dark skin tone";
## 1F468 200D 1F52C                           ; fully-qualified     # 👨‍🔬 E4.0 man scientist # emoji-test.txt line #1174 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F52C⟆ 👨‍🔬 E4.0 man scientist";
## 1F468 1F3FB 200D 1F52C                     ; fully-qualified     # 👨🏻‍🔬 E4.0 man scientist: light skin tone # emoji-test.txt line #1175 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F52C⟆ 👨🏻‍🔬 E4.0 man scientist: light skin tone";
## 1F468 1F3FC 200D 1F52C                     ; fully-qualified     # 👨🏼‍🔬 E4.0 man scientist: medium-light skin tone # emoji-test.txt line #1176 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F52C⟆ 👨🏼‍🔬 E4.0 man scientist: medium-light skin tone";
## 1F468 1F3FD 200D 1F52C                     ; fully-qualified     # 👨🏽‍🔬 E4.0 man scientist: medium skin tone # emoji-test.txt line #1177 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F52C⟆ 👨🏽‍🔬 E4.0 man scientist: medium skin tone";
## 1F468 1F3FE 200D 1F52C                     ; fully-qualified     # 👨🏾‍🔬 E4.0 man scientist: medium-dark skin tone # emoji-test.txt line #1178 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F52C⟆ 👨🏾‍🔬 E4.0 man scientist: medium-dark skin tone";
## 1F468 1F3FF 200D 1F52C                     ; fully-qualified     # 👨🏿‍🔬 E4.0 man scientist: dark skin tone # emoji-test.txt line #1179 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F52C⟆ 👨🏿‍🔬 E4.0 man scientist: dark skin tone";
## 1F469 200D 1F52C                           ; fully-qualified     # 👩‍🔬 E4.0 woman scientist # emoji-test.txt line #1180 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F52C⟆ 👩‍🔬 E4.0 woman scientist";
## 1F469 1F3FB 200D 1F52C                     ; fully-qualified     # 👩🏻‍🔬 E4.0 woman scientist: light skin tone # emoji-test.txt line #1181 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F52C⟆ 👩🏻‍🔬 E4.0 woman scientist: light skin tone";
## 1F469 1F3FC 200D 1F52C                     ; fully-qualified     # 👩🏼‍🔬 E4.0 woman scientist: medium-light skin tone # emoji-test.txt line #1182 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F52C⟆ 👩🏼‍🔬 E4.0 woman scientist: medium-light skin tone";
## 1F469 1F3FD 200D 1F52C                     ; fully-qualified     # 👩🏽‍🔬 E4.0 woman scientist: medium skin tone # emoji-test.txt line #1183 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F52C⟆ 👩🏽‍🔬 E4.0 woman scientist: medium skin tone";
## 1F469 1F3FE 200D 1F52C                     ; fully-qualified     # 👩🏾‍🔬 E4.0 woman scientist: medium-dark skin tone # emoji-test.txt line #1184 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F52C⟆ 👩🏾‍🔬 E4.0 woman scientist: medium-dark skin tone";
## 1F469 1F3FF 200D 1F52C                     ; fully-qualified     # 👩🏿‍🔬 E4.0 woman scientist: dark skin tone # emoji-test.txt line #1185 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F52C).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F52C⟆ 👩🏿‍🔬 E4.0 woman scientist: dark skin tone";
## 1F9D1 200D 1F4BB                           ; fully-qualified     # 🧑‍💻 E12.1 technologist # emoji-test.txt line #1186 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F4BB⟆ 🧑‍💻 E12.1 technologist";
## 1F9D1 1F3FB 200D 1F4BB                     ; fully-qualified     # 🧑🏻‍💻 E12.1 technologist: light skin tone # emoji-test.txt line #1187 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F4BB⟆ 🧑🏻‍💻 E12.1 technologist: light skin tone";
## 1F9D1 1F3FC 200D 1F4BB                     ; fully-qualified     # 🧑🏼‍💻 E12.1 technologist: medium-light skin tone # emoji-test.txt line #1188 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F4BB⟆ 🧑🏼‍💻 E12.1 technologist: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F4BB                     ; fully-qualified     # 🧑🏽‍💻 E12.1 technologist: medium skin tone # emoji-test.txt line #1189 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F4BB⟆ 🧑🏽‍💻 E12.1 technologist: medium skin tone";
## 1F9D1 1F3FE 200D 1F4BB                     ; fully-qualified     # 🧑🏾‍💻 E12.1 technologist: medium-dark skin tone # emoji-test.txt line #1190 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F4BB⟆ 🧑🏾‍💻 E12.1 technologist: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F4BB                     ; fully-qualified     # 🧑🏿‍💻 E12.1 technologist: dark skin tone # emoji-test.txt line #1191 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F4BB⟆ 🧑🏿‍💻 E12.1 technologist: dark skin tone";
## 1F468 200D 1F4BB                           ; fully-qualified     # 👨‍💻 E4.0 man technologist # emoji-test.txt line #1192 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F4BB⟆ 👨‍💻 E4.0 man technologist";
## 1F468 1F3FB 200D 1F4BB                     ; fully-qualified     # 👨🏻‍💻 E4.0 man technologist: light skin tone # emoji-test.txt line #1193 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F4BB⟆ 👨🏻‍💻 E4.0 man technologist: light skin tone";
## 1F468 1F3FC 200D 1F4BB                     ; fully-qualified     # 👨🏼‍💻 E4.0 man technologist: medium-light skin tone # emoji-test.txt line #1194 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F4BB⟆ 👨🏼‍💻 E4.0 man technologist: medium-light skin tone";
## 1F468 1F3FD 200D 1F4BB                     ; fully-qualified     # 👨🏽‍💻 E4.0 man technologist: medium skin tone # emoji-test.txt line #1195 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F4BB⟆ 👨🏽‍💻 E4.0 man technologist: medium skin tone";
## 1F468 1F3FE 200D 1F4BB                     ; fully-qualified     # 👨🏾‍💻 E4.0 man technologist: medium-dark skin tone # emoji-test.txt line #1196 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F4BB⟆ 👨🏾‍💻 E4.0 man technologist: medium-dark skin tone";
## 1F468 1F3FF 200D 1F4BB                     ; fully-qualified     # 👨🏿‍💻 E4.0 man technologist: dark skin tone # emoji-test.txt line #1197 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F4BB⟆ 👨🏿‍💻 E4.0 man technologist: dark skin tone";
## 1F469 200D 1F4BB                           ; fully-qualified     # 👩‍💻 E4.0 woman technologist # emoji-test.txt line #1198 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F4BB⟆ 👩‍💻 E4.0 woman technologist";
## 1F469 1F3FB 200D 1F4BB                     ; fully-qualified     # 👩🏻‍💻 E4.0 woman technologist: light skin tone # emoji-test.txt line #1199 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F4BB⟆ 👩🏻‍💻 E4.0 woman technologist: light skin tone";
## 1F469 1F3FC 200D 1F4BB                     ; fully-qualified     # 👩🏼‍💻 E4.0 woman technologist: medium-light skin tone # emoji-test.txt line #1200 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F4BB⟆ 👩🏼‍💻 E4.0 woman technologist: medium-light skin tone";
## 1F469 1F3FD 200D 1F4BB                     ; fully-qualified     # 👩🏽‍💻 E4.0 woman technologist: medium skin tone # emoji-test.txt line #1201 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F4BB⟆ 👩🏽‍💻 E4.0 woman technologist: medium skin tone";
## 1F469 1F3FE 200D 1F4BB                     ; fully-qualified     # 👩🏾‍💻 E4.0 woman technologist: medium-dark skin tone # emoji-test.txt line #1202 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F4BB⟆ 👩🏾‍💻 E4.0 woman technologist: medium-dark skin tone";
## 1F469 1F3FF 200D 1F4BB                     ; fully-qualified     # 👩🏿‍💻 E4.0 woman technologist: dark skin tone # emoji-test.txt line #1203 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F4BB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F4BB⟆ 👩🏿‍💻 E4.0 woman technologist: dark skin tone";
## 1F9D1 200D 1F3A4                           ; fully-qualified     # 🧑‍🎤 E12.1 singer # emoji-test.txt line #1204 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F3A4⟆ 🧑‍🎤 E12.1 singer";
## 1F9D1 1F3FB 200D 1F3A4                     ; fully-qualified     # 🧑🏻‍🎤 E12.1 singer: light skin tone # emoji-test.txt line #1205 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F3A4⟆ 🧑🏻‍🎤 E12.1 singer: light skin tone";
## 1F9D1 1F3FC 200D 1F3A4                     ; fully-qualified     # 🧑🏼‍🎤 E12.1 singer: medium-light skin tone # emoji-test.txt line #1206 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F3A4⟆ 🧑🏼‍🎤 E12.1 singer: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F3A4                     ; fully-qualified     # 🧑🏽‍🎤 E12.1 singer: medium skin tone # emoji-test.txt line #1207 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F3A4⟆ 🧑🏽‍🎤 E12.1 singer: medium skin tone";
## 1F9D1 1F3FE 200D 1F3A4                     ; fully-qualified     # 🧑🏾‍🎤 E12.1 singer: medium-dark skin tone # emoji-test.txt line #1208 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F3A4⟆ 🧑🏾‍🎤 E12.1 singer: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F3A4                     ; fully-qualified     # 🧑🏿‍🎤 E12.1 singer: dark skin tone # emoji-test.txt line #1209 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F3A4⟆ 🧑🏿‍🎤 E12.1 singer: dark skin tone";
## 1F468 200D 1F3A4                           ; fully-qualified     # 👨‍🎤 E4.0 man singer # emoji-test.txt line #1210 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F3A4⟆ 👨‍🎤 E4.0 man singer";
## 1F468 1F3FB 200D 1F3A4                     ; fully-qualified     # 👨🏻‍🎤 E4.0 man singer: light skin tone # emoji-test.txt line #1211 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F3A4⟆ 👨🏻‍🎤 E4.0 man singer: light skin tone";
## 1F468 1F3FC 200D 1F3A4                     ; fully-qualified     # 👨🏼‍🎤 E4.0 man singer: medium-light skin tone # emoji-test.txt line #1212 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F3A4⟆ 👨🏼‍🎤 E4.0 man singer: medium-light skin tone";
## 1F468 1F3FD 200D 1F3A4                     ; fully-qualified     # 👨🏽‍🎤 E4.0 man singer: medium skin tone # emoji-test.txt line #1213 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F3A4⟆ 👨🏽‍🎤 E4.0 man singer: medium skin tone";
## 1F468 1F3FE 200D 1F3A4                     ; fully-qualified     # 👨🏾‍🎤 E4.0 man singer: medium-dark skin tone # emoji-test.txt line #1214 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F3A4⟆ 👨🏾‍🎤 E4.0 man singer: medium-dark skin tone";
## 1F468 1F3FF 200D 1F3A4                     ; fully-qualified     # 👨🏿‍🎤 E4.0 man singer: dark skin tone # emoji-test.txt line #1215 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F3A4⟆ 👨🏿‍🎤 E4.0 man singer: dark skin tone";
## 1F469 200D 1F3A4                           ; fully-qualified     # 👩‍🎤 E4.0 woman singer # emoji-test.txt line #1216 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F3A4⟆ 👩‍🎤 E4.0 woman singer";
## 1F469 1F3FB 200D 1F3A4                     ; fully-qualified     # 👩🏻‍🎤 E4.0 woman singer: light skin tone # emoji-test.txt line #1217 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F3A4⟆ 👩🏻‍🎤 E4.0 woman singer: light skin tone";
## 1F469 1F3FC 200D 1F3A4                     ; fully-qualified     # 👩🏼‍🎤 E4.0 woman singer: medium-light skin tone # emoji-test.txt line #1218 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F3A4⟆ 👩🏼‍🎤 E4.0 woman singer: medium-light skin tone";
## 1F469 1F3FD 200D 1F3A4                     ; fully-qualified     # 👩🏽‍🎤 E4.0 woman singer: medium skin tone # emoji-test.txt line #1219 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F3A4⟆ 👩🏽‍🎤 E4.0 woman singer: medium skin tone";
## 1F469 1F3FE 200D 1F3A4                     ; fully-qualified     # 👩🏾‍🎤 E4.0 woman singer: medium-dark skin tone # emoji-test.txt line #1220 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F3A4⟆ 👩🏾‍🎤 E4.0 woman singer: medium-dark skin tone";
## 1F469 1F3FF 200D 1F3A4                     ; fully-qualified     # 👩🏿‍🎤 E4.0 woman singer: dark skin tone # emoji-test.txt line #1221 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F3A4).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F3A4⟆ 👩🏿‍🎤 E4.0 woman singer: dark skin tone";
## 1F9D1 200D 1F3A8                           ; fully-qualified     # 🧑‍🎨 E12.1 artist # emoji-test.txt line #1222 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F3A8⟆ 🧑‍🎨 E12.1 artist";
## 1F9D1 1F3FB 200D 1F3A8                     ; fully-qualified     # 🧑🏻‍🎨 E12.1 artist: light skin tone # emoji-test.txt line #1223 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F3A8⟆ 🧑🏻‍🎨 E12.1 artist: light skin tone";
## 1F9D1 1F3FC 200D 1F3A8                     ; fully-qualified     # 🧑🏼‍🎨 E12.1 artist: medium-light skin tone # emoji-test.txt line #1224 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F3A8⟆ 🧑🏼‍🎨 E12.1 artist: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F3A8                     ; fully-qualified     # 🧑🏽‍🎨 E12.1 artist: medium skin tone # emoji-test.txt line #1225 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F3A8⟆ 🧑🏽‍🎨 E12.1 artist: medium skin tone";
## 1F9D1 1F3FE 200D 1F3A8                     ; fully-qualified     # 🧑🏾‍🎨 E12.1 artist: medium-dark skin tone # emoji-test.txt line #1226 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F3A8⟆ 🧑🏾‍🎨 E12.1 artist: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F3A8                     ; fully-qualified     # 🧑🏿‍🎨 E12.1 artist: dark skin tone # emoji-test.txt line #1227 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F3A8⟆ 🧑🏿‍🎨 E12.1 artist: dark skin tone";
## 1F468 200D 1F3A8                           ; fully-qualified     # 👨‍🎨 E4.0 man artist # emoji-test.txt line #1228 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F3A8⟆ 👨‍🎨 E4.0 man artist";
## 1F468 1F3FB 200D 1F3A8                     ; fully-qualified     # 👨🏻‍🎨 E4.0 man artist: light skin tone # emoji-test.txt line #1229 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F3A8⟆ 👨🏻‍🎨 E4.0 man artist: light skin tone";
## 1F468 1F3FC 200D 1F3A8                     ; fully-qualified     # 👨🏼‍🎨 E4.0 man artist: medium-light skin tone # emoji-test.txt line #1230 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F3A8⟆ 👨🏼‍🎨 E4.0 man artist: medium-light skin tone";
## 1F468 1F3FD 200D 1F3A8                     ; fully-qualified     # 👨🏽‍🎨 E4.0 man artist: medium skin tone # emoji-test.txt line #1231 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F3A8⟆ 👨🏽‍🎨 E4.0 man artist: medium skin tone";
## 1F468 1F3FE 200D 1F3A8                     ; fully-qualified     # 👨🏾‍🎨 E4.0 man artist: medium-dark skin tone # emoji-test.txt line #1232 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F3A8⟆ 👨🏾‍🎨 E4.0 man artist: medium-dark skin tone";
## 1F468 1F3FF 200D 1F3A8                     ; fully-qualified     # 👨🏿‍🎨 E4.0 man artist: dark skin tone # emoji-test.txt line #1233 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F3A8⟆ 👨🏿‍🎨 E4.0 man artist: dark skin tone";
## 1F469 200D 1F3A8                           ; fully-qualified     # 👩‍🎨 E4.0 woman artist # emoji-test.txt line #1234 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F3A8⟆ 👩‍🎨 E4.0 woman artist";
## 1F469 1F3FB 200D 1F3A8                     ; fully-qualified     # 👩🏻‍🎨 E4.0 woman artist: light skin tone # emoji-test.txt line #1235 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F3A8⟆ 👩🏻‍🎨 E4.0 woman artist: light skin tone";
## 1F469 1F3FC 200D 1F3A8                     ; fully-qualified     # 👩🏼‍🎨 E4.0 woman artist: medium-light skin tone # emoji-test.txt line #1236 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F3A8⟆ 👩🏼‍🎨 E4.0 woman artist: medium-light skin tone";
## 1F469 1F3FD 200D 1F3A8                     ; fully-qualified     # 👩🏽‍🎨 E4.0 woman artist: medium skin tone # emoji-test.txt line #1237 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F3A8⟆ 👩🏽‍🎨 E4.0 woman artist: medium skin tone";
## 1F469 1F3FE 200D 1F3A8                     ; fully-qualified     # 👩🏾‍🎨 E4.0 woman artist: medium-dark skin tone # emoji-test.txt line #1238 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F3A8⟆ 👩🏾‍🎨 E4.0 woman artist: medium-dark skin tone";
## 1F469 1F3FF 200D 1F3A8                     ; fully-qualified     # 👩🏿‍🎨 E4.0 woman artist: dark skin tone # emoji-test.txt line #1239 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F3A8).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F3A8⟆ 👩🏿‍🎨 E4.0 woman artist: dark skin tone";
## 1F9D1 200D 2708 FE0F                       ; fully-qualified     # 🧑‍✈️ E12.1 pilot # emoji-test.txt line #1240 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x2708, 0xFE0F⟆ 🧑‍✈️ E12.1 pilot";
## 1F9D1 200D 2708                            ; minimally-qualified # 🧑‍✈ E12.1 pilot # emoji-test.txt line #1241 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x2708⟆ 🧑‍✈ E12.1 pilot";
## 1F9D1 1F3FB 200D 2708 FE0F                 ; fully-qualified     # 🧑🏻‍✈️ E12.1 pilot: light skin tone # emoji-test.txt line #1242 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x2708, 0xFE0F⟆ 🧑🏻‍✈️ E12.1 pilot: light skin tone";
## 1F9D1 1F3FB 200D 2708                      ; minimally-qualified # 🧑🏻‍✈ E12.1 pilot: light skin tone # emoji-test.txt line #1243 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x2708⟆ 🧑🏻‍✈ E12.1 pilot: light skin tone";
## 1F9D1 1F3FC 200D 2708 FE0F                 ; fully-qualified     # 🧑🏼‍✈️ E12.1 pilot: medium-light skin tone # emoji-test.txt line #1244 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x2708, 0xFE0F⟆ 🧑🏼‍✈️ E12.1 pilot: medium-light skin tone";
## 1F9D1 1F3FC 200D 2708                      ; minimally-qualified # 🧑🏼‍✈ E12.1 pilot: medium-light skin tone # emoji-test.txt line #1245 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x2708⟆ 🧑🏼‍✈ E12.1 pilot: medium-light skin tone";
## 1F9D1 1F3FD 200D 2708 FE0F                 ; fully-qualified     # 🧑🏽‍✈️ E12.1 pilot: medium skin tone # emoji-test.txt line #1246 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x2708, 0xFE0F⟆ 🧑🏽‍✈️ E12.1 pilot: medium skin tone";
## 1F9D1 1F3FD 200D 2708                      ; minimally-qualified # 🧑🏽‍✈ E12.1 pilot: medium skin tone # emoji-test.txt line #1247 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x2708⟆ 🧑🏽‍✈ E12.1 pilot: medium skin tone";
## 1F9D1 1F3FE 200D 2708 FE0F                 ; fully-qualified     # 🧑🏾‍✈️ E12.1 pilot: medium-dark skin tone # emoji-test.txt line #1248 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x2708, 0xFE0F⟆ 🧑🏾‍✈️ E12.1 pilot: medium-dark skin tone";
## 1F9D1 1F3FE 200D 2708                      ; minimally-qualified # 🧑🏾‍✈ E12.1 pilot: medium-dark skin tone # emoji-test.txt line #1249 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x2708⟆ 🧑🏾‍✈ E12.1 pilot: medium-dark skin tone";
## 1F9D1 1F3FF 200D 2708 FE0F                 ; fully-qualified     # 🧑🏿‍✈️ E12.1 pilot: dark skin tone # emoji-test.txt line #1250 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x2708, 0xFE0F⟆ 🧑🏿‍✈️ E12.1 pilot: dark skin tone";
## 1F9D1 1F3FF 200D 2708                      ; minimally-qualified # 🧑🏿‍✈ E12.1 pilot: dark skin tone # emoji-test.txt line #1251 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x2708⟆ 🧑🏿‍✈ E12.1 pilot: dark skin tone";
## 1F468 200D 2708 FE0F                       ; fully-qualified     # 👨‍✈️ E4.0 man pilot # emoji-test.txt line #1252 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x2708, 0xFE0F⟆ 👨‍✈️ E4.0 man pilot";
## 1F468 200D 2708                            ; minimally-qualified # 👨‍✈ E4.0 man pilot # emoji-test.txt line #1253 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x2708⟆ 👨‍✈ E4.0 man pilot";
## 1F468 1F3FB 200D 2708 FE0F                 ; fully-qualified     # 👨🏻‍✈️ E4.0 man pilot: light skin tone # emoji-test.txt line #1254 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x2708, 0xFE0F⟆ 👨🏻‍✈️ E4.0 man pilot: light skin tone";
## 1F468 1F3FB 200D 2708                      ; minimally-qualified # 👨🏻‍✈ E4.0 man pilot: light skin tone # emoji-test.txt line #1255 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x2708⟆ 👨🏻‍✈ E4.0 man pilot: light skin tone";
## 1F468 1F3FC 200D 2708 FE0F                 ; fully-qualified     # 👨🏼‍✈️ E4.0 man pilot: medium-light skin tone # emoji-test.txt line #1256 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x2708, 0xFE0F⟆ 👨🏼‍✈️ E4.0 man pilot: medium-light skin tone";
## 1F468 1F3FC 200D 2708                      ; minimally-qualified # 👨🏼‍✈ E4.0 man pilot: medium-light skin tone # emoji-test.txt line #1257 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x2708⟆ 👨🏼‍✈ E4.0 man pilot: medium-light skin tone";
## 1F468 1F3FD 200D 2708 FE0F                 ; fully-qualified     # 👨🏽‍✈️ E4.0 man pilot: medium skin tone # emoji-test.txt line #1258 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x2708, 0xFE0F⟆ 👨🏽‍✈️ E4.0 man pilot: medium skin tone";
## 1F468 1F3FD 200D 2708                      ; minimally-qualified # 👨🏽‍✈ E4.0 man pilot: medium skin tone # emoji-test.txt line #1259 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x2708⟆ 👨🏽‍✈ E4.0 man pilot: medium skin tone";
## 1F468 1F3FE 200D 2708 FE0F                 ; fully-qualified     # 👨🏾‍✈️ E4.0 man pilot: medium-dark skin tone # emoji-test.txt line #1260 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x2708, 0xFE0F⟆ 👨🏾‍✈️ E4.0 man pilot: medium-dark skin tone";
## 1F468 1F3FE 200D 2708                      ; minimally-qualified # 👨🏾‍✈ E4.0 man pilot: medium-dark skin tone # emoji-test.txt line #1261 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x2708⟆ 👨🏾‍✈ E4.0 man pilot: medium-dark skin tone";
## 1F468 1F3FF 200D 2708 FE0F                 ; fully-qualified     # 👨🏿‍✈️ E4.0 man pilot: dark skin tone # emoji-test.txt line #1262 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x2708, 0xFE0F⟆ 👨🏿‍✈️ E4.0 man pilot: dark skin tone";
## 1F468 1F3FF 200D 2708                      ; minimally-qualified # 👨🏿‍✈ E4.0 man pilot: dark skin tone # emoji-test.txt line #1263 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x2708⟆ 👨🏿‍✈ E4.0 man pilot: dark skin tone";
## 1F469 200D 2708 FE0F                       ; fully-qualified     # 👩‍✈️ E4.0 woman pilot # emoji-test.txt line #1264 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2708, 0xFE0F⟆ 👩‍✈️ E4.0 woman pilot";
## 1F469 200D 2708                            ; minimally-qualified # 👩‍✈ E4.0 woman pilot # emoji-test.txt line #1265 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2708⟆ 👩‍✈ E4.0 woman pilot";
## 1F469 1F3FB 200D 2708 FE0F                 ; fully-qualified     # 👩🏻‍✈️ E4.0 woman pilot: light skin tone # emoji-test.txt line #1266 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x2708, 0xFE0F⟆ 👩🏻‍✈️ E4.0 woman pilot: light skin tone";
## 1F469 1F3FB 200D 2708                      ; minimally-qualified # 👩🏻‍✈ E4.0 woman pilot: light skin tone # emoji-test.txt line #1267 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x2708⟆ 👩🏻‍✈ E4.0 woman pilot: light skin tone";
## 1F469 1F3FC 200D 2708 FE0F                 ; fully-qualified     # 👩🏼‍✈️ E4.0 woman pilot: medium-light skin tone # emoji-test.txt line #1268 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x2708, 0xFE0F⟆ 👩🏼‍✈️ E4.0 woman pilot: medium-light skin tone";
## 1F469 1F3FC 200D 2708                      ; minimally-qualified # 👩🏼‍✈ E4.0 woman pilot: medium-light skin tone # emoji-test.txt line #1269 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x2708⟆ 👩🏼‍✈ E4.0 woman pilot: medium-light skin tone";
## 1F469 1F3FD 200D 2708 FE0F                 ; fully-qualified     # 👩🏽‍✈️ E4.0 woman pilot: medium skin tone # emoji-test.txt line #1270 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x2708, 0xFE0F⟆ 👩🏽‍✈️ E4.0 woman pilot: medium skin tone";
## 1F469 1F3FD 200D 2708                      ; minimally-qualified # 👩🏽‍✈ E4.0 woman pilot: medium skin tone # emoji-test.txt line #1271 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x2708⟆ 👩🏽‍✈ E4.0 woman pilot: medium skin tone";
## 1F469 1F3FE 200D 2708 FE0F                 ; fully-qualified     # 👩🏾‍✈️ E4.0 woman pilot: medium-dark skin tone # emoji-test.txt line #1272 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x2708, 0xFE0F⟆ 👩🏾‍✈️ E4.0 woman pilot: medium-dark skin tone";
## 1F469 1F3FE 200D 2708                      ; minimally-qualified # 👩🏾‍✈ E4.0 woman pilot: medium-dark skin tone # emoji-test.txt line #1273 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x2708⟆ 👩🏾‍✈ E4.0 woman pilot: medium-dark skin tone";
## 1F469 1F3FF 200D 2708 FE0F                 ; fully-qualified     # 👩🏿‍✈️ E4.0 woman pilot: dark skin tone # emoji-test.txt line #1274 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x2708, 0xFE0F⟆ 👩🏿‍✈️ E4.0 woman pilot: dark skin tone";
## 1F469 1F3FF 200D 2708                      ; minimally-qualified # 👩🏿‍✈ E4.0 woman pilot: dark skin tone # emoji-test.txt line #1275 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x2708).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x2708⟆ 👩🏿‍✈ E4.0 woman pilot: dark skin tone";
## 1F9D1 200D 1F680                           ; fully-qualified     # 🧑‍🚀 E12.1 astronaut # emoji-test.txt line #1276 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F680⟆ 🧑‍🚀 E12.1 astronaut";
## 1F9D1 1F3FB 200D 1F680                     ; fully-qualified     # 🧑🏻‍🚀 E12.1 astronaut: light skin tone # emoji-test.txt line #1277 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F680⟆ 🧑🏻‍🚀 E12.1 astronaut: light skin tone";
## 1F9D1 1F3FC 200D 1F680                     ; fully-qualified     # 🧑🏼‍🚀 E12.1 astronaut: medium-light skin tone # emoji-test.txt line #1278 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F680⟆ 🧑🏼‍🚀 E12.1 astronaut: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F680                     ; fully-qualified     # 🧑🏽‍🚀 E12.1 astronaut: medium skin tone # emoji-test.txt line #1279 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F680⟆ 🧑🏽‍🚀 E12.1 astronaut: medium skin tone";
## 1F9D1 1F3FE 200D 1F680                     ; fully-qualified     # 🧑🏾‍🚀 E12.1 astronaut: medium-dark skin tone # emoji-test.txt line #1280 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F680⟆ 🧑🏾‍🚀 E12.1 astronaut: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F680                     ; fully-qualified     # 🧑🏿‍🚀 E12.1 astronaut: dark skin tone # emoji-test.txt line #1281 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F680⟆ 🧑🏿‍🚀 E12.1 astronaut: dark skin tone";
## 1F468 200D 1F680                           ; fully-qualified     # 👨‍🚀 E4.0 man astronaut # emoji-test.txt line #1282 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F680⟆ 👨‍🚀 E4.0 man astronaut";
## 1F468 1F3FB 200D 1F680                     ; fully-qualified     # 👨🏻‍🚀 E4.0 man astronaut: light skin tone # emoji-test.txt line #1283 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F680⟆ 👨🏻‍🚀 E4.0 man astronaut: light skin tone";
## 1F468 1F3FC 200D 1F680                     ; fully-qualified     # 👨🏼‍🚀 E4.0 man astronaut: medium-light skin tone # emoji-test.txt line #1284 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F680⟆ 👨🏼‍🚀 E4.0 man astronaut: medium-light skin tone";
## 1F468 1F3FD 200D 1F680                     ; fully-qualified     # 👨🏽‍🚀 E4.0 man astronaut: medium skin tone # emoji-test.txt line #1285 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F680⟆ 👨🏽‍🚀 E4.0 man astronaut: medium skin tone";
## 1F468 1F3FE 200D 1F680                     ; fully-qualified     # 👨🏾‍🚀 E4.0 man astronaut: medium-dark skin tone # emoji-test.txt line #1286 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F680⟆ 👨🏾‍🚀 E4.0 man astronaut: medium-dark skin tone";
## 1F468 1F3FF 200D 1F680                     ; fully-qualified     # 👨🏿‍🚀 E4.0 man astronaut: dark skin tone # emoji-test.txt line #1287 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F680⟆ 👨🏿‍🚀 E4.0 man astronaut: dark skin tone";
## 1F469 200D 1F680                           ; fully-qualified     # 👩‍🚀 E4.0 woman astronaut # emoji-test.txt line #1288 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F680⟆ 👩‍🚀 E4.0 woman astronaut";
## 1F469 1F3FB 200D 1F680                     ; fully-qualified     # 👩🏻‍🚀 E4.0 woman astronaut: light skin tone # emoji-test.txt line #1289 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F680⟆ 👩🏻‍🚀 E4.0 woman astronaut: light skin tone";
## 1F469 1F3FC 200D 1F680                     ; fully-qualified     # 👩🏼‍🚀 E4.0 woman astronaut: medium-light skin tone # emoji-test.txt line #1290 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F680⟆ 👩🏼‍🚀 E4.0 woman astronaut: medium-light skin tone";
## 1F469 1F3FD 200D 1F680                     ; fully-qualified     # 👩🏽‍🚀 E4.0 woman astronaut: medium skin tone # emoji-test.txt line #1291 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F680⟆ 👩🏽‍🚀 E4.0 woman astronaut: medium skin tone";
## 1F469 1F3FE 200D 1F680                     ; fully-qualified     # 👩🏾‍🚀 E4.0 woman astronaut: medium-dark skin tone # emoji-test.txt line #1292 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F680⟆ 👩🏾‍🚀 E4.0 woman astronaut: medium-dark skin tone";
## 1F469 1F3FF 200D 1F680                     ; fully-qualified     # 👩🏿‍🚀 E4.0 woman astronaut: dark skin tone # emoji-test.txt line #1293 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F680).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F680⟆ 👩🏿‍🚀 E4.0 woman astronaut: dark skin tone";
## 1F9D1 200D 1F692                           ; fully-qualified     # 🧑‍🚒 E12.1 firefighter # emoji-test.txt line #1294 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F692⟆ 🧑‍🚒 E12.1 firefighter";
## 1F9D1 1F3FB 200D 1F692                     ; fully-qualified     # 🧑🏻‍🚒 E12.1 firefighter: light skin tone # emoji-test.txt line #1295 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F692⟆ 🧑🏻‍🚒 E12.1 firefighter: light skin tone";
## 1F9D1 1F3FC 200D 1F692                     ; fully-qualified     # 🧑🏼‍🚒 E12.1 firefighter: medium-light skin tone # emoji-test.txt line #1296 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F692⟆ 🧑🏼‍🚒 E12.1 firefighter: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F692                     ; fully-qualified     # 🧑🏽‍🚒 E12.1 firefighter: medium skin tone # emoji-test.txt line #1297 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F692⟆ 🧑🏽‍🚒 E12.1 firefighter: medium skin tone";
## 1F9D1 1F3FE 200D 1F692                     ; fully-qualified     # 🧑🏾‍🚒 E12.1 firefighter: medium-dark skin tone # emoji-test.txt line #1298 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F692⟆ 🧑🏾‍🚒 E12.1 firefighter: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F692                     ; fully-qualified     # 🧑🏿‍🚒 E12.1 firefighter: dark skin tone # emoji-test.txt line #1299 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F692⟆ 🧑🏿‍🚒 E12.1 firefighter: dark skin tone";
## 1F468 200D 1F692                           ; fully-qualified     # 👨‍🚒 E4.0 man firefighter # emoji-test.txt line #1300 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F692⟆ 👨‍🚒 E4.0 man firefighter";
## 1F468 1F3FB 200D 1F692                     ; fully-qualified     # 👨🏻‍🚒 E4.0 man firefighter: light skin tone # emoji-test.txt line #1301 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F692⟆ 👨🏻‍🚒 E4.0 man firefighter: light skin tone";
## 1F468 1F3FC 200D 1F692                     ; fully-qualified     # 👨🏼‍🚒 E4.0 man firefighter: medium-light skin tone # emoji-test.txt line #1302 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F692⟆ 👨🏼‍🚒 E4.0 man firefighter: medium-light skin tone";
## 1F468 1F3FD 200D 1F692                     ; fully-qualified     # 👨🏽‍🚒 E4.0 man firefighter: medium skin tone # emoji-test.txt line #1303 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F692⟆ 👨🏽‍🚒 E4.0 man firefighter: medium skin tone";
## 1F468 1F3FE 200D 1F692                     ; fully-qualified     # 👨🏾‍🚒 E4.0 man firefighter: medium-dark skin tone # emoji-test.txt line #1304 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F692⟆ 👨🏾‍🚒 E4.0 man firefighter: medium-dark skin tone";
## 1F468 1F3FF 200D 1F692                     ; fully-qualified     # 👨🏿‍🚒 E4.0 man firefighter: dark skin tone # emoji-test.txt line #1305 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F692⟆ 👨🏿‍🚒 E4.0 man firefighter: dark skin tone";
## 1F469 200D 1F692                           ; fully-qualified     # 👩‍🚒 E4.0 woman firefighter # emoji-test.txt line #1306 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F692⟆ 👩‍🚒 E4.0 woman firefighter";
## 1F469 1F3FB 200D 1F692                     ; fully-qualified     # 👩🏻‍🚒 E4.0 woman firefighter: light skin tone # emoji-test.txt line #1307 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F692⟆ 👩🏻‍🚒 E4.0 woman firefighter: light skin tone";
## 1F469 1F3FC 200D 1F692                     ; fully-qualified     # 👩🏼‍🚒 E4.0 woman firefighter: medium-light skin tone # emoji-test.txt line #1308 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F692⟆ 👩🏼‍🚒 E4.0 woman firefighter: medium-light skin tone";
## 1F469 1F3FD 200D 1F692                     ; fully-qualified     # 👩🏽‍🚒 E4.0 woman firefighter: medium skin tone # emoji-test.txt line #1309 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F692⟆ 👩🏽‍🚒 E4.0 woman firefighter: medium skin tone";
## 1F469 1F3FE 200D 1F692                     ; fully-qualified     # 👩🏾‍🚒 E4.0 woman firefighter: medium-dark skin tone # emoji-test.txt line #1310 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F692⟆ 👩🏾‍🚒 E4.0 woman firefighter: medium-dark skin tone";
## 1F469 1F3FF 200D 1F692                     ; fully-qualified     # 👩🏿‍🚒 E4.0 woman firefighter: dark skin tone # emoji-test.txt line #1311 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F692).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F692⟆ 👩🏿‍🚒 E4.0 woman firefighter: dark skin tone";
## 1F46E 1F3FB                                ; fully-qualified     # 👮🏻 E1.0 police officer: light skin tone # emoji-test.txt line #1313 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FB⟆ 👮🏻 E1.0 police officer: light skin tone";
## 1F46E 1F3FC                                ; fully-qualified     # 👮🏼 E1.0 police officer: medium-light skin tone # emoji-test.txt line #1314 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FC⟆ 👮🏼 E1.0 police officer: medium-light skin tone";
## 1F46E 1F3FD                                ; fully-qualified     # 👮🏽 E1.0 police officer: medium skin tone # emoji-test.txt line #1315 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FD⟆ 👮🏽 E1.0 police officer: medium skin tone";
## 1F46E 1F3FE                                ; fully-qualified     # 👮🏾 E1.0 police officer: medium-dark skin tone # emoji-test.txt line #1316 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FE⟆ 👮🏾 E1.0 police officer: medium-dark skin tone";
## 1F46E 1F3FF                                ; fully-qualified     # 👮🏿 E1.0 police officer: dark skin tone # emoji-test.txt line #1317 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FF⟆ 👮🏿 E1.0 police officer: dark skin tone";
## 1F46E 200D 2642 FE0F                       ; fully-qualified     # 👮‍♂️ E4.0 man police officer # emoji-test.txt line #1318 Emoji version 13.0
is Uni.new(0x1F46E, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x200D, 0x2642, 0xFE0F⟆ 👮‍♂️ E4.0 man police officer";
## 1F46E 200D 2642                            ; minimally-qualified # 👮‍♂ E4.0 man police officer # emoji-test.txt line #1319 Emoji version 13.0
is Uni.new(0x1F46E, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F46E, 0x200D, 0x2642⟆ 👮‍♂ E4.0 man police officer";
## 1F46E 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 👮🏻‍♂️ E4.0 man police officer: light skin tone # emoji-test.txt line #1320 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 👮🏻‍♂️ E4.0 man police officer: light skin tone";
## 1F46E 1F3FB 200D 2642                      ; minimally-qualified # 👮🏻‍♂ E4.0 man police officer: light skin tone # emoji-test.txt line #1321 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FB, 0x200D, 0x2642⟆ 👮🏻‍♂ E4.0 man police officer: light skin tone";
## 1F46E 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 👮🏼‍♂️ E4.0 man police officer: medium-light skin tone # emoji-test.txt line #1322 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 👮🏼‍♂️ E4.0 man police officer: medium-light skin tone";
## 1F46E 1F3FC 200D 2642                      ; minimally-qualified # 👮🏼‍♂ E4.0 man police officer: medium-light skin tone # emoji-test.txt line #1323 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FC, 0x200D, 0x2642⟆ 👮🏼‍♂ E4.0 man police officer: medium-light skin tone";
## 1F46E 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 👮🏽‍♂️ E4.0 man police officer: medium skin tone # emoji-test.txt line #1324 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 👮🏽‍♂️ E4.0 man police officer: medium skin tone";
## 1F46E 1F3FD 200D 2642                      ; minimally-qualified # 👮🏽‍♂ E4.0 man police officer: medium skin tone # emoji-test.txt line #1325 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FD, 0x200D, 0x2642⟆ 👮🏽‍♂ E4.0 man police officer: medium skin tone";
## 1F46E 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 👮🏾‍♂️ E4.0 man police officer: medium-dark skin tone # emoji-test.txt line #1326 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 👮🏾‍♂️ E4.0 man police officer: medium-dark skin tone";
## 1F46E 1F3FE 200D 2642                      ; minimally-qualified # 👮🏾‍♂ E4.0 man police officer: medium-dark skin tone # emoji-test.txt line #1327 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FE, 0x200D, 0x2642⟆ 👮🏾‍♂ E4.0 man police officer: medium-dark skin tone";
## 1F46E 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 👮🏿‍♂️ E4.0 man police officer: dark skin tone # emoji-test.txt line #1328 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 👮🏿‍♂️ E4.0 man police officer: dark skin tone";
## 1F46E 1F3FF 200D 2642                      ; minimally-qualified # 👮🏿‍♂ E4.0 man police officer: dark skin tone # emoji-test.txt line #1329 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FF, 0x200D, 0x2642⟆ 👮🏿‍♂ E4.0 man police officer: dark skin tone";
## 1F46E 200D 2640 FE0F                       ; fully-qualified     # 👮‍♀️ E4.0 woman police officer # emoji-test.txt line #1330 Emoji version 13.0
is Uni.new(0x1F46E, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x200D, 0x2640, 0xFE0F⟆ 👮‍♀️ E4.0 woman police officer";
## 1F46E 200D 2640                            ; minimally-qualified # 👮‍♀ E4.0 woman police officer # emoji-test.txt line #1331 Emoji version 13.0
is Uni.new(0x1F46E, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F46E, 0x200D, 0x2640⟆ 👮‍♀ E4.0 woman police officer";
## 1F46E 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 👮🏻‍♀️ E4.0 woman police officer: light skin tone # emoji-test.txt line #1332 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 👮🏻‍♀️ E4.0 woman police officer: light skin tone";
## 1F46E 1F3FB 200D 2640                      ; minimally-qualified # 👮🏻‍♀ E4.0 woman police officer: light skin tone # emoji-test.txt line #1333 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FB, 0x200D, 0x2640⟆ 👮🏻‍♀ E4.0 woman police officer: light skin tone";
## 1F46E 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 👮🏼‍♀️ E4.0 woman police officer: medium-light skin tone # emoji-test.txt line #1334 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 👮🏼‍♀️ E4.0 woman police officer: medium-light skin tone";
## 1F46E 1F3FC 200D 2640                      ; minimally-qualified # 👮🏼‍♀ E4.0 woman police officer: medium-light skin tone # emoji-test.txt line #1335 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FC, 0x200D, 0x2640⟆ 👮🏼‍♀ E4.0 woman police officer: medium-light skin tone";
## 1F46E 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 👮🏽‍♀️ E4.0 woman police officer: medium skin tone # emoji-test.txt line #1336 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 👮🏽‍♀️ E4.0 woman police officer: medium skin tone";
## 1F46E 1F3FD 200D 2640                      ; minimally-qualified # 👮🏽‍♀ E4.0 woman police officer: medium skin tone # emoji-test.txt line #1337 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FD, 0x200D, 0x2640⟆ 👮🏽‍♀ E4.0 woman police officer: medium skin tone";
## 1F46E 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 👮🏾‍♀️ E4.0 woman police officer: medium-dark skin tone # emoji-test.txt line #1338 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 👮🏾‍♀️ E4.0 woman police officer: medium-dark skin tone";
## 1F46E 1F3FE 200D 2640                      ; minimally-qualified # 👮🏾‍♀ E4.0 woman police officer: medium-dark skin tone # emoji-test.txt line #1339 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FE, 0x200D, 0x2640⟆ 👮🏾‍♀ E4.0 woman police officer: medium-dark skin tone";
## 1F46E 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 👮🏿‍♀️ E4.0 woman police officer: dark skin tone # emoji-test.txt line #1340 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 👮🏿‍♀️ E4.0 woman police officer: dark skin tone";
## 1F46E 1F3FF 200D 2640                      ; minimally-qualified # 👮🏿‍♀ E4.0 woman police officer: dark skin tone # emoji-test.txt line #1341 Emoji version 13.0
is Uni.new(0x1F46E, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F46E, 0x1F3FF, 0x200D, 0x2640⟆ 👮🏿‍♀ E4.0 woman police officer: dark skin tone";
## 1F575 FE0F                                 ; fully-qualified     # 🕵️ E0.7 detective # emoji-test.txt line #1342 Emoji version 13.0
is Uni.new(0x1F575, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0xFE0F⟆ 🕵️ E0.7 detective";
## 1F575 1F3FB                                ; fully-qualified     # 🕵🏻 E2.0 detective: light skin tone # emoji-test.txt line #1344 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FB⟆ 🕵🏻 E2.0 detective: light skin tone";
## 1F575 1F3FC                                ; fully-qualified     # 🕵🏼 E2.0 detective: medium-light skin tone # emoji-test.txt line #1345 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FC⟆ 🕵🏼 E2.0 detective: medium-light skin tone";
## 1F575 1F3FD                                ; fully-qualified     # 🕵🏽 E2.0 detective: medium skin tone # emoji-test.txt line #1346 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FD⟆ 🕵🏽 E2.0 detective: medium skin tone";
## 1F575 1F3FE                                ; fully-qualified     # 🕵🏾 E2.0 detective: medium-dark skin tone # emoji-test.txt line #1347 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FE⟆ 🕵🏾 E2.0 detective: medium-dark skin tone";
## 1F575 1F3FF                                ; fully-qualified     # 🕵🏿 E2.0 detective: dark skin tone # emoji-test.txt line #1348 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FF⟆ 🕵🏿 E2.0 detective: dark skin tone";
## 1F575 FE0F 200D 2642 FE0F                  ; fully-qualified     # 🕵️‍♂️ E4.0 man detective # emoji-test.txt line #1349 Emoji version 13.0
is Uni.new(0x1F575, 0xFE0F, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0xFE0F, 0x200D, 0x2642, 0xFE0F⟆ 🕵️‍♂️ E4.0 man detective";
## 1F575 200D 2642 FE0F                       ; unqualified         # 🕵‍♂️ E4.0 man detective # emoji-test.txt line #1350 Emoji version 13.0
is Uni.new(0x1F575, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x200D, 0x2642, 0xFE0F⟆ 🕵‍♂️ E4.0 man detective";
## 1F575 FE0F 200D 2642                       ; unqualified         # 🕵️‍♂ E4.0 man detective # emoji-test.txt line #1351 Emoji version 13.0
is Uni.new(0x1F575, 0xFE0F, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F575, 0xFE0F, 0x200D, 0x2642⟆ 🕵️‍♂ E4.0 man detective";
## 1F575 200D 2642                            ; unqualified         # 🕵‍♂ E4.0 man detective # emoji-test.txt line #1352 Emoji version 13.0
is Uni.new(0x1F575, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F575, 0x200D, 0x2642⟆ 🕵‍♂ E4.0 man detective";
## 1F575 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🕵🏻‍♂️ E4.0 man detective: light skin tone # emoji-test.txt line #1353 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🕵🏻‍♂️ E4.0 man detective: light skin tone";
## 1F575 1F3FB 200D 2642                      ; minimally-qualified # 🕵🏻‍♂ E4.0 man detective: light skin tone # emoji-test.txt line #1354 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FB, 0x200D, 0x2642⟆ 🕵🏻‍♂ E4.0 man detective: light skin tone";
## 1F575 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🕵🏼‍♂️ E4.0 man detective: medium-light skin tone # emoji-test.txt line #1355 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🕵🏼‍♂️ E4.0 man detective: medium-light skin tone";
## 1F575 1F3FC 200D 2642                      ; minimally-qualified # 🕵🏼‍♂ E4.0 man detective: medium-light skin tone # emoji-test.txt line #1356 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FC, 0x200D, 0x2642⟆ 🕵🏼‍♂ E4.0 man detective: medium-light skin tone";
## 1F575 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🕵🏽‍♂️ E4.0 man detective: medium skin tone # emoji-test.txt line #1357 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🕵🏽‍♂️ E4.0 man detective: medium skin tone";
## 1F575 1F3FD 200D 2642                      ; minimally-qualified # 🕵🏽‍♂ E4.0 man detective: medium skin tone # emoji-test.txt line #1358 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FD, 0x200D, 0x2642⟆ 🕵🏽‍♂ E4.0 man detective: medium skin tone";
## 1F575 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🕵🏾‍♂️ E4.0 man detective: medium-dark skin tone # emoji-test.txt line #1359 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🕵🏾‍♂️ E4.0 man detective: medium-dark skin tone";
## 1F575 1F3FE 200D 2642                      ; minimally-qualified # 🕵🏾‍♂ E4.0 man detective: medium-dark skin tone # emoji-test.txt line #1360 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FE, 0x200D, 0x2642⟆ 🕵🏾‍♂ E4.0 man detective: medium-dark skin tone";
## 1F575 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🕵🏿‍♂️ E4.0 man detective: dark skin tone # emoji-test.txt line #1361 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🕵🏿‍♂️ E4.0 man detective: dark skin tone";
## 1F575 1F3FF 200D 2642                      ; minimally-qualified # 🕵🏿‍♂ E4.0 man detective: dark skin tone # emoji-test.txt line #1362 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FF, 0x200D, 0x2642⟆ 🕵🏿‍♂ E4.0 man detective: dark skin tone";
## 1F575 FE0F 200D 2640 FE0F                  ; fully-qualified     # 🕵️‍♀️ E4.0 woman detective # emoji-test.txt line #1363 Emoji version 13.0
is Uni.new(0x1F575, 0xFE0F, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0xFE0F, 0x200D, 0x2640, 0xFE0F⟆ 🕵️‍♀️ E4.0 woman detective";
## 1F575 200D 2640 FE0F                       ; unqualified         # 🕵‍♀️ E4.0 woman detective # emoji-test.txt line #1364 Emoji version 13.0
is Uni.new(0x1F575, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x200D, 0x2640, 0xFE0F⟆ 🕵‍♀️ E4.0 woman detective";
## 1F575 FE0F 200D 2640                       ; unqualified         # 🕵️‍♀ E4.0 woman detective # emoji-test.txt line #1365 Emoji version 13.0
is Uni.new(0x1F575, 0xFE0F, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F575, 0xFE0F, 0x200D, 0x2640⟆ 🕵️‍♀ E4.0 woman detective";
## 1F575 200D 2640                            ; unqualified         # 🕵‍♀ E4.0 woman detective # emoji-test.txt line #1366 Emoji version 13.0
is Uni.new(0x1F575, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F575, 0x200D, 0x2640⟆ 🕵‍♀ E4.0 woman detective";
## 1F575 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🕵🏻‍♀️ E4.0 woman detective: light skin tone # emoji-test.txt line #1367 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🕵🏻‍♀️ E4.0 woman detective: light skin tone";
## 1F575 1F3FB 200D 2640                      ; minimally-qualified # 🕵🏻‍♀ E4.0 woman detective: light skin tone # emoji-test.txt line #1368 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FB, 0x200D, 0x2640⟆ 🕵🏻‍♀ E4.0 woman detective: light skin tone";
## 1F575 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🕵🏼‍♀️ E4.0 woman detective: medium-light skin tone # emoji-test.txt line #1369 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🕵🏼‍♀️ E4.0 woman detective: medium-light skin tone";
## 1F575 1F3FC 200D 2640                      ; minimally-qualified # 🕵🏼‍♀ E4.0 woman detective: medium-light skin tone # emoji-test.txt line #1370 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FC, 0x200D, 0x2640⟆ 🕵🏼‍♀ E4.0 woman detective: medium-light skin tone";
## 1F575 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🕵🏽‍♀️ E4.0 woman detective: medium skin tone # emoji-test.txt line #1371 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🕵🏽‍♀️ E4.0 woman detective: medium skin tone";
## 1F575 1F3FD 200D 2640                      ; minimally-qualified # 🕵🏽‍♀ E4.0 woman detective: medium skin tone # emoji-test.txt line #1372 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FD, 0x200D, 0x2640⟆ 🕵🏽‍♀ E4.0 woman detective: medium skin tone";
## 1F575 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🕵🏾‍♀️ E4.0 woman detective: medium-dark skin tone # emoji-test.txt line #1373 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🕵🏾‍♀️ E4.0 woman detective: medium-dark skin tone";
## 1F575 1F3FE 200D 2640                      ; minimally-qualified # 🕵🏾‍♀ E4.0 woman detective: medium-dark skin tone # emoji-test.txt line #1374 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FE, 0x200D, 0x2640⟆ 🕵🏾‍♀ E4.0 woman detective: medium-dark skin tone";
## 1F575 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🕵🏿‍♀️ E4.0 woman detective: dark skin tone # emoji-test.txt line #1375 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🕵🏿‍♀️ E4.0 woman detective: dark skin tone";
## 1F575 1F3FF 200D 2640                      ; minimally-qualified # 🕵🏿‍♀ E4.0 woman detective: dark skin tone # emoji-test.txt line #1376 Emoji version 13.0
is Uni.new(0x1F575, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F575, 0x1F3FF, 0x200D, 0x2640⟆ 🕵🏿‍♀ E4.0 woman detective: dark skin tone";
## 1F482 1F3FB                                ; fully-qualified     # 💂🏻 E1.0 guard: light skin tone # emoji-test.txt line #1378 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FB⟆ 💂🏻 E1.0 guard: light skin tone";
## 1F482 1F3FC                                ; fully-qualified     # 💂🏼 E1.0 guard: medium-light skin tone # emoji-test.txt line #1379 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FC⟆ 💂🏼 E1.0 guard: medium-light skin tone";
## 1F482 1F3FD                                ; fully-qualified     # 💂🏽 E1.0 guard: medium skin tone # emoji-test.txt line #1380 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FD⟆ 💂🏽 E1.0 guard: medium skin tone";
## 1F482 1F3FE                                ; fully-qualified     # 💂🏾 E1.0 guard: medium-dark skin tone # emoji-test.txt line #1381 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FE⟆ 💂🏾 E1.0 guard: medium-dark skin tone";
## 1F482 1F3FF                                ; fully-qualified     # 💂🏿 E1.0 guard: dark skin tone # emoji-test.txt line #1382 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FF⟆ 💂🏿 E1.0 guard: dark skin tone";
## 1F482 200D 2642 FE0F                       ; fully-qualified     # 💂‍♂️ E4.0 man guard # emoji-test.txt line #1383 Emoji version 13.0
is Uni.new(0x1F482, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x200D, 0x2642, 0xFE0F⟆ 💂‍♂️ E4.0 man guard";
## 1F482 200D 2642                            ; minimally-qualified # 💂‍♂ E4.0 man guard # emoji-test.txt line #1384 Emoji version 13.0
is Uni.new(0x1F482, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F482, 0x200D, 0x2642⟆ 💂‍♂ E4.0 man guard";
## 1F482 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 💂🏻‍♂️ E4.0 man guard: light skin tone # emoji-test.txt line #1385 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 💂🏻‍♂️ E4.0 man guard: light skin tone";
## 1F482 1F3FB 200D 2642                      ; minimally-qualified # 💂🏻‍♂ E4.0 man guard: light skin tone # emoji-test.txt line #1386 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FB, 0x200D, 0x2642⟆ 💂🏻‍♂ E4.0 man guard: light skin tone";
## 1F482 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 💂🏼‍♂️ E4.0 man guard: medium-light skin tone # emoji-test.txt line #1387 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 💂🏼‍♂️ E4.0 man guard: medium-light skin tone";
## 1F482 1F3FC 200D 2642                      ; minimally-qualified # 💂🏼‍♂ E4.0 man guard: medium-light skin tone # emoji-test.txt line #1388 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FC, 0x200D, 0x2642⟆ 💂🏼‍♂ E4.0 man guard: medium-light skin tone";
## 1F482 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 💂🏽‍♂️ E4.0 man guard: medium skin tone # emoji-test.txt line #1389 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 💂🏽‍♂️ E4.0 man guard: medium skin tone";
## 1F482 1F3FD 200D 2642                      ; minimally-qualified # 💂🏽‍♂ E4.0 man guard: medium skin tone # emoji-test.txt line #1390 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FD, 0x200D, 0x2642⟆ 💂🏽‍♂ E4.0 man guard: medium skin tone";
## 1F482 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 💂🏾‍♂️ E4.0 man guard: medium-dark skin tone # emoji-test.txt line #1391 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 💂🏾‍♂️ E4.0 man guard: medium-dark skin tone";
## 1F482 1F3FE 200D 2642                      ; minimally-qualified # 💂🏾‍♂ E4.0 man guard: medium-dark skin tone # emoji-test.txt line #1392 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FE, 0x200D, 0x2642⟆ 💂🏾‍♂ E4.0 man guard: medium-dark skin tone";
## 1F482 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 💂🏿‍♂️ E4.0 man guard: dark skin tone # emoji-test.txt line #1393 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 💂🏿‍♂️ E4.0 man guard: dark skin tone";
## 1F482 1F3FF 200D 2642                      ; minimally-qualified # 💂🏿‍♂ E4.0 man guard: dark skin tone # emoji-test.txt line #1394 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FF, 0x200D, 0x2642⟆ 💂🏿‍♂ E4.0 man guard: dark skin tone";
## 1F482 200D 2640 FE0F                       ; fully-qualified     # 💂‍♀️ E4.0 woman guard # emoji-test.txt line #1395 Emoji version 13.0
is Uni.new(0x1F482, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x200D, 0x2640, 0xFE0F⟆ 💂‍♀️ E4.0 woman guard";
## 1F482 200D 2640                            ; minimally-qualified # 💂‍♀ E4.0 woman guard # emoji-test.txt line #1396 Emoji version 13.0
is Uni.new(0x1F482, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F482, 0x200D, 0x2640⟆ 💂‍♀ E4.0 woman guard";
## 1F482 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 💂🏻‍♀️ E4.0 woman guard: light skin tone # emoji-test.txt line #1397 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 💂🏻‍♀️ E4.0 woman guard: light skin tone";
## 1F482 1F3FB 200D 2640                      ; minimally-qualified # 💂🏻‍♀ E4.0 woman guard: light skin tone # emoji-test.txt line #1398 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FB, 0x200D, 0x2640⟆ 💂🏻‍♀ E4.0 woman guard: light skin tone";
## 1F482 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 💂🏼‍♀️ E4.0 woman guard: medium-light skin tone # emoji-test.txt line #1399 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 💂🏼‍♀️ E4.0 woman guard: medium-light skin tone";
## 1F482 1F3FC 200D 2640                      ; minimally-qualified # 💂🏼‍♀ E4.0 woman guard: medium-light skin tone # emoji-test.txt line #1400 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FC, 0x200D, 0x2640⟆ 💂🏼‍♀ E4.0 woman guard: medium-light skin tone";
## 1F482 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 💂🏽‍♀️ E4.0 woman guard: medium skin tone # emoji-test.txt line #1401 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 💂🏽‍♀️ E4.0 woman guard: medium skin tone";
## 1F482 1F3FD 200D 2640                      ; minimally-qualified # 💂🏽‍♀ E4.0 woman guard: medium skin tone # emoji-test.txt line #1402 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FD, 0x200D, 0x2640⟆ 💂🏽‍♀ E4.0 woman guard: medium skin tone";
## 1F482 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 💂🏾‍♀️ E4.0 woman guard: medium-dark skin tone # emoji-test.txt line #1403 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 💂🏾‍♀️ E4.0 woman guard: medium-dark skin tone";
## 1F482 1F3FE 200D 2640                      ; minimally-qualified # 💂🏾‍♀ E4.0 woman guard: medium-dark skin tone # emoji-test.txt line #1404 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FE, 0x200D, 0x2640⟆ 💂🏾‍♀ E4.0 woman guard: medium-dark skin tone";
## 1F482 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 💂🏿‍♀️ E4.0 woman guard: dark skin tone # emoji-test.txt line #1405 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 💂🏿‍♀️ E4.0 woman guard: dark skin tone";
## 1F482 1F3FF 200D 2640                      ; minimally-qualified # 💂🏿‍♀ E4.0 woman guard: dark skin tone # emoji-test.txt line #1406 Emoji version 13.0
is Uni.new(0x1F482, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F482, 0x1F3FF, 0x200D, 0x2640⟆ 💂🏿‍♀ E4.0 woman guard: dark skin tone";
## 1F977 1F3FB                                ; fully-qualified     # 🥷🏻 E13.0 ninja: light skin tone # emoji-test.txt line #1408 Emoji version 13.0
is Uni.new(0x1F977, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F977, 0x1F3FB⟆ 🥷🏻 E13.0 ninja: light skin tone";
## 1F977 1F3FC                                ; fully-qualified     # 🥷🏼 E13.0 ninja: medium-light skin tone # emoji-test.txt line #1409 Emoji version 13.0
is Uni.new(0x1F977, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F977, 0x1F3FC⟆ 🥷🏼 E13.0 ninja: medium-light skin tone";
## 1F977 1F3FD                                ; fully-qualified     # 🥷🏽 E13.0 ninja: medium skin tone # emoji-test.txt line #1410 Emoji version 13.0
is Uni.new(0x1F977, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F977, 0x1F3FD⟆ 🥷🏽 E13.0 ninja: medium skin tone";
## 1F977 1F3FE                                ; fully-qualified     # 🥷🏾 E13.0 ninja: medium-dark skin tone # emoji-test.txt line #1411 Emoji version 13.0
is Uni.new(0x1F977, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F977, 0x1F3FE⟆ 🥷🏾 E13.0 ninja: medium-dark skin tone";
## 1F977 1F3FF                                ; fully-qualified     # 🥷🏿 E13.0 ninja: dark skin tone # emoji-test.txt line #1412 Emoji version 13.0
is Uni.new(0x1F977, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F977, 0x1F3FF⟆ 🥷🏿 E13.0 ninja: dark skin tone";
## 1F477 1F3FB                                ; fully-qualified     # 👷🏻 E1.0 construction worker: light skin tone # emoji-test.txt line #1414 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FB⟆ 👷🏻 E1.0 construction worker: light skin tone";
## 1F477 1F3FC                                ; fully-qualified     # 👷🏼 E1.0 construction worker: medium-light skin tone # emoji-test.txt line #1415 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FC⟆ 👷🏼 E1.0 construction worker: medium-light skin tone";
## 1F477 1F3FD                                ; fully-qualified     # 👷🏽 E1.0 construction worker: medium skin tone # emoji-test.txt line #1416 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FD⟆ 👷🏽 E1.0 construction worker: medium skin tone";
## 1F477 1F3FE                                ; fully-qualified     # 👷🏾 E1.0 construction worker: medium-dark skin tone # emoji-test.txt line #1417 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FE⟆ 👷🏾 E1.0 construction worker: medium-dark skin tone";
## 1F477 1F3FF                                ; fully-qualified     # 👷🏿 E1.0 construction worker: dark skin tone # emoji-test.txt line #1418 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FF⟆ 👷🏿 E1.0 construction worker: dark skin tone";
## 1F477 200D 2642 FE0F                       ; fully-qualified     # 👷‍♂️ E4.0 man construction worker # emoji-test.txt line #1419 Emoji version 13.0
is Uni.new(0x1F477, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x200D, 0x2642, 0xFE0F⟆ 👷‍♂️ E4.0 man construction worker";
## 1F477 200D 2642                            ; minimally-qualified # 👷‍♂ E4.0 man construction worker # emoji-test.txt line #1420 Emoji version 13.0
is Uni.new(0x1F477, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F477, 0x200D, 0x2642⟆ 👷‍♂ E4.0 man construction worker";
## 1F477 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 👷🏻‍♂️ E4.0 man construction worker: light skin tone # emoji-test.txt line #1421 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 👷🏻‍♂️ E4.0 man construction worker: light skin tone";
## 1F477 1F3FB 200D 2642                      ; minimally-qualified # 👷🏻‍♂ E4.0 man construction worker: light skin tone # emoji-test.txt line #1422 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FB, 0x200D, 0x2642⟆ 👷🏻‍♂ E4.0 man construction worker: light skin tone";
## 1F477 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 👷🏼‍♂️ E4.0 man construction worker: medium-light skin tone # emoji-test.txt line #1423 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 👷🏼‍♂️ E4.0 man construction worker: medium-light skin tone";
## 1F477 1F3FC 200D 2642                      ; minimally-qualified # 👷🏼‍♂ E4.0 man construction worker: medium-light skin tone # emoji-test.txt line #1424 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FC, 0x200D, 0x2642⟆ 👷🏼‍♂ E4.0 man construction worker: medium-light skin tone";
## 1F477 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 👷🏽‍♂️ E4.0 man construction worker: medium skin tone # emoji-test.txt line #1425 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 👷🏽‍♂️ E4.0 man construction worker: medium skin tone";
## 1F477 1F3FD 200D 2642                      ; minimally-qualified # 👷🏽‍♂ E4.0 man construction worker: medium skin tone # emoji-test.txt line #1426 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FD, 0x200D, 0x2642⟆ 👷🏽‍♂ E4.0 man construction worker: medium skin tone";
## 1F477 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 👷🏾‍♂️ E4.0 man construction worker: medium-dark skin tone # emoji-test.txt line #1427 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 👷🏾‍♂️ E4.0 man construction worker: medium-dark skin tone";
## 1F477 1F3FE 200D 2642                      ; minimally-qualified # 👷🏾‍♂ E4.0 man construction worker: medium-dark skin tone # emoji-test.txt line #1428 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FE, 0x200D, 0x2642⟆ 👷🏾‍♂ E4.0 man construction worker: medium-dark skin tone";
## 1F477 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 👷🏿‍♂️ E4.0 man construction worker: dark skin tone # emoji-test.txt line #1429 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 👷🏿‍♂️ E4.0 man construction worker: dark skin tone";
## 1F477 1F3FF 200D 2642                      ; minimally-qualified # 👷🏿‍♂ E4.0 man construction worker: dark skin tone # emoji-test.txt line #1430 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FF, 0x200D, 0x2642⟆ 👷🏿‍♂ E4.0 man construction worker: dark skin tone";
## 1F477 200D 2640 FE0F                       ; fully-qualified     # 👷‍♀️ E4.0 woman construction worker # emoji-test.txt line #1431 Emoji version 13.0
is Uni.new(0x1F477, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x200D, 0x2640, 0xFE0F⟆ 👷‍♀️ E4.0 woman construction worker";
## 1F477 200D 2640                            ; minimally-qualified # 👷‍♀ E4.0 woman construction worker # emoji-test.txt line #1432 Emoji version 13.0
is Uni.new(0x1F477, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F477, 0x200D, 0x2640⟆ 👷‍♀ E4.0 woman construction worker";
## 1F477 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 👷🏻‍♀️ E4.0 woman construction worker: light skin tone # emoji-test.txt line #1433 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 👷🏻‍♀️ E4.0 woman construction worker: light skin tone";
## 1F477 1F3FB 200D 2640                      ; minimally-qualified # 👷🏻‍♀ E4.0 woman construction worker: light skin tone # emoji-test.txt line #1434 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FB, 0x200D, 0x2640⟆ 👷🏻‍♀ E4.0 woman construction worker: light skin tone";
## 1F477 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 👷🏼‍♀️ E4.0 woman construction worker: medium-light skin tone # emoji-test.txt line #1435 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 👷🏼‍♀️ E4.0 woman construction worker: medium-light skin tone";
## 1F477 1F3FC 200D 2640                      ; minimally-qualified # 👷🏼‍♀ E4.0 woman construction worker: medium-light skin tone # emoji-test.txt line #1436 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FC, 0x200D, 0x2640⟆ 👷🏼‍♀ E4.0 woman construction worker: medium-light skin tone";
## 1F477 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 👷🏽‍♀️ E4.0 woman construction worker: medium skin tone # emoji-test.txt line #1437 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 👷🏽‍♀️ E4.0 woman construction worker: medium skin tone";
## 1F477 1F3FD 200D 2640                      ; minimally-qualified # 👷🏽‍♀ E4.0 woman construction worker: medium skin tone # emoji-test.txt line #1438 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FD, 0x200D, 0x2640⟆ 👷🏽‍♀ E4.0 woman construction worker: medium skin tone";
## 1F477 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 👷🏾‍♀️ E4.0 woman construction worker: medium-dark skin tone # emoji-test.txt line #1439 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 👷🏾‍♀️ E4.0 woman construction worker: medium-dark skin tone";
## 1F477 1F3FE 200D 2640                      ; minimally-qualified # 👷🏾‍♀ E4.0 woman construction worker: medium-dark skin tone # emoji-test.txt line #1440 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FE, 0x200D, 0x2640⟆ 👷🏾‍♀ E4.0 woman construction worker: medium-dark skin tone";
## 1F477 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 👷🏿‍♀️ E4.0 woman construction worker: dark skin tone # emoji-test.txt line #1441 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 👷🏿‍♀️ E4.0 woman construction worker: dark skin tone";
## 1F477 1F3FF 200D 2640                      ; minimally-qualified # 👷🏿‍♀ E4.0 woman construction worker: dark skin tone # emoji-test.txt line #1442 Emoji version 13.0
is Uni.new(0x1F477, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F477, 0x1F3FF, 0x200D, 0x2640⟆ 👷🏿‍♀ E4.0 woman construction worker: dark skin tone";
## 1F934 1F3FB                                ; fully-qualified     # 🤴🏻 E3.0 prince: light skin tone # emoji-test.txt line #1444 Emoji version 13.0
is Uni.new(0x1F934, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F934, 0x1F3FB⟆ 🤴🏻 E3.0 prince: light skin tone";
## 1F934 1F3FC                                ; fully-qualified     # 🤴🏼 E3.0 prince: medium-light skin tone # emoji-test.txt line #1445 Emoji version 13.0
is Uni.new(0x1F934, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F934, 0x1F3FC⟆ 🤴🏼 E3.0 prince: medium-light skin tone";
## 1F934 1F3FD                                ; fully-qualified     # 🤴🏽 E3.0 prince: medium skin tone # emoji-test.txt line #1446 Emoji version 13.0
is Uni.new(0x1F934, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F934, 0x1F3FD⟆ 🤴🏽 E3.0 prince: medium skin tone";
## 1F934 1F3FE                                ; fully-qualified     # 🤴🏾 E3.0 prince: medium-dark skin tone # emoji-test.txt line #1447 Emoji version 13.0
is Uni.new(0x1F934, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F934, 0x1F3FE⟆ 🤴🏾 E3.0 prince: medium-dark skin tone";
## 1F934 1F3FF                                ; fully-qualified     # 🤴🏿 E3.0 prince: dark skin tone # emoji-test.txt line #1448 Emoji version 13.0
is Uni.new(0x1F934, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F934, 0x1F3FF⟆ 🤴🏿 E3.0 prince: dark skin tone";
## 1F478 1F3FB                                ; fully-qualified     # 👸🏻 E1.0 princess: light skin tone # emoji-test.txt line #1450 Emoji version 13.0
is Uni.new(0x1F478, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F478, 0x1F3FB⟆ 👸🏻 E1.0 princess: light skin tone";
## 1F478 1F3FC                                ; fully-qualified     # 👸🏼 E1.0 princess: medium-light skin tone # emoji-test.txt line #1451 Emoji version 13.0
is Uni.new(0x1F478, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F478, 0x1F3FC⟆ 👸🏼 E1.0 princess: medium-light skin tone";
## 1F478 1F3FD                                ; fully-qualified     # 👸🏽 E1.0 princess: medium skin tone # emoji-test.txt line #1452 Emoji version 13.0
is Uni.new(0x1F478, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F478, 0x1F3FD⟆ 👸🏽 E1.0 princess: medium skin tone";
## 1F478 1F3FE                                ; fully-qualified     # 👸🏾 E1.0 princess: medium-dark skin tone # emoji-test.txt line #1453 Emoji version 13.0
is Uni.new(0x1F478, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F478, 0x1F3FE⟆ 👸🏾 E1.0 princess: medium-dark skin tone";
## 1F478 1F3FF                                ; fully-qualified     # 👸🏿 E1.0 princess: dark skin tone # emoji-test.txt line #1454 Emoji version 13.0
is Uni.new(0x1F478, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F478, 0x1F3FF⟆ 👸🏿 E1.0 princess: dark skin tone";
## 1F473 1F3FB                                ; fully-qualified     # 👳🏻 E1.0 person wearing turban: light skin tone # emoji-test.txt line #1456 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FB⟆ 👳🏻 E1.0 person wearing turban: light skin tone";
## 1F473 1F3FC                                ; fully-qualified     # 👳🏼 E1.0 person wearing turban: medium-light skin tone # emoji-test.txt line #1457 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FC⟆ 👳🏼 E1.0 person wearing turban: medium-light skin tone";
## 1F473 1F3FD                                ; fully-qualified     # 👳🏽 E1.0 person wearing turban: medium skin tone # emoji-test.txt line #1458 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FD⟆ 👳🏽 E1.0 person wearing turban: medium skin tone";
## 1F473 1F3FE                                ; fully-qualified     # 👳🏾 E1.0 person wearing turban: medium-dark skin tone # emoji-test.txt line #1459 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FE⟆ 👳🏾 E1.0 person wearing turban: medium-dark skin tone";
## 1F473 1F3FF                                ; fully-qualified     # 👳🏿 E1.0 person wearing turban: dark skin tone # emoji-test.txt line #1460 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FF⟆ 👳🏿 E1.0 person wearing turban: dark skin tone";
## 1F473 200D 2642 FE0F                       ; fully-qualified     # 👳‍♂️ E4.0 man wearing turban # emoji-test.txt line #1461 Emoji version 13.0
is Uni.new(0x1F473, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x200D, 0x2642, 0xFE0F⟆ 👳‍♂️ E4.0 man wearing turban";
## 1F473 200D 2642                            ; minimally-qualified # 👳‍♂ E4.0 man wearing turban # emoji-test.txt line #1462 Emoji version 13.0
is Uni.new(0x1F473, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F473, 0x200D, 0x2642⟆ 👳‍♂ E4.0 man wearing turban";
## 1F473 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 👳🏻‍♂️ E4.0 man wearing turban: light skin tone # emoji-test.txt line #1463 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 👳🏻‍♂️ E4.0 man wearing turban: light skin tone";
## 1F473 1F3FB 200D 2642                      ; minimally-qualified # 👳🏻‍♂ E4.0 man wearing turban: light skin tone # emoji-test.txt line #1464 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FB, 0x200D, 0x2642⟆ 👳🏻‍♂ E4.0 man wearing turban: light skin tone";
## 1F473 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 👳🏼‍♂️ E4.0 man wearing turban: medium-light skin tone # emoji-test.txt line #1465 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 👳🏼‍♂️ E4.0 man wearing turban: medium-light skin tone";
## 1F473 1F3FC 200D 2642                      ; minimally-qualified # 👳🏼‍♂ E4.0 man wearing turban: medium-light skin tone # emoji-test.txt line #1466 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FC, 0x200D, 0x2642⟆ 👳🏼‍♂ E4.0 man wearing turban: medium-light skin tone";
## 1F473 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 👳🏽‍♂️ E4.0 man wearing turban: medium skin tone # emoji-test.txt line #1467 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 👳🏽‍♂️ E4.0 man wearing turban: medium skin tone";
## 1F473 1F3FD 200D 2642                      ; minimally-qualified # 👳🏽‍♂ E4.0 man wearing turban: medium skin tone # emoji-test.txt line #1468 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FD, 0x200D, 0x2642⟆ 👳🏽‍♂ E4.0 man wearing turban: medium skin tone";
## 1F473 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 👳🏾‍♂️ E4.0 man wearing turban: medium-dark skin tone # emoji-test.txt line #1469 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 👳🏾‍♂️ E4.0 man wearing turban: medium-dark skin tone";
## 1F473 1F3FE 200D 2642                      ; minimally-qualified # 👳🏾‍♂ E4.0 man wearing turban: medium-dark skin tone # emoji-test.txt line #1470 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FE, 0x200D, 0x2642⟆ 👳🏾‍♂ E4.0 man wearing turban: medium-dark skin tone";
## 1F473 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 👳🏿‍♂️ E4.0 man wearing turban: dark skin tone # emoji-test.txt line #1471 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 👳🏿‍♂️ E4.0 man wearing turban: dark skin tone";
## 1F473 1F3FF 200D 2642                      ; minimally-qualified # 👳🏿‍♂ E4.0 man wearing turban: dark skin tone # emoji-test.txt line #1472 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FF, 0x200D, 0x2642⟆ 👳🏿‍♂ E4.0 man wearing turban: dark skin tone";
## 1F473 200D 2640 FE0F                       ; fully-qualified     # 👳‍♀️ E4.0 woman wearing turban # emoji-test.txt line #1473 Emoji version 13.0
is Uni.new(0x1F473, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x200D, 0x2640, 0xFE0F⟆ 👳‍♀️ E4.0 woman wearing turban";
## 1F473 200D 2640                            ; minimally-qualified # 👳‍♀ E4.0 woman wearing turban # emoji-test.txt line #1474 Emoji version 13.0
is Uni.new(0x1F473, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F473, 0x200D, 0x2640⟆ 👳‍♀ E4.0 woman wearing turban";
## 1F473 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 👳🏻‍♀️ E4.0 woman wearing turban: light skin tone # emoji-test.txt line #1475 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 👳🏻‍♀️ E4.0 woman wearing turban: light skin tone";
## 1F473 1F3FB 200D 2640                      ; minimally-qualified # 👳🏻‍♀ E4.0 woman wearing turban: light skin tone # emoji-test.txt line #1476 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FB, 0x200D, 0x2640⟆ 👳🏻‍♀ E4.0 woman wearing turban: light skin tone";
## 1F473 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 👳🏼‍♀️ E4.0 woman wearing turban: medium-light skin tone # emoji-test.txt line #1477 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 👳🏼‍♀️ E4.0 woman wearing turban: medium-light skin tone";
## 1F473 1F3FC 200D 2640                      ; minimally-qualified # 👳🏼‍♀ E4.0 woman wearing turban: medium-light skin tone # emoji-test.txt line #1478 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FC, 0x200D, 0x2640⟆ 👳🏼‍♀ E4.0 woman wearing turban: medium-light skin tone";
## 1F473 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 👳🏽‍♀️ E4.0 woman wearing turban: medium skin tone # emoji-test.txt line #1479 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 👳🏽‍♀️ E4.0 woman wearing turban: medium skin tone";
## 1F473 1F3FD 200D 2640                      ; minimally-qualified # 👳🏽‍♀ E4.0 woman wearing turban: medium skin tone # emoji-test.txt line #1480 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FD, 0x200D, 0x2640⟆ 👳🏽‍♀ E4.0 woman wearing turban: medium skin tone";
## 1F473 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 👳🏾‍♀️ E4.0 woman wearing turban: medium-dark skin tone # emoji-test.txt line #1481 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 👳🏾‍♀️ E4.0 woman wearing turban: medium-dark skin tone";
## 1F473 1F3FE 200D 2640                      ; minimally-qualified # 👳🏾‍♀ E4.0 woman wearing turban: medium-dark skin tone # emoji-test.txt line #1482 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FE, 0x200D, 0x2640⟆ 👳🏾‍♀ E4.0 woman wearing turban: medium-dark skin tone";
## 1F473 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 👳🏿‍♀️ E4.0 woman wearing turban: dark skin tone # emoji-test.txt line #1483 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 👳🏿‍♀️ E4.0 woman wearing turban: dark skin tone";
## 1F473 1F3FF 200D 2640                      ; minimally-qualified # 👳🏿‍♀ E4.0 woman wearing turban: dark skin tone # emoji-test.txt line #1484 Emoji version 13.0
is Uni.new(0x1F473, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F473, 0x1F3FF, 0x200D, 0x2640⟆ 👳🏿‍♀ E4.0 woman wearing turban: dark skin tone";
## 1F472 1F3FB                                ; fully-qualified     # 👲🏻 E1.0 person with skullcap: light skin tone # emoji-test.txt line #1486 Emoji version 13.0
is Uni.new(0x1F472, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F472, 0x1F3FB⟆ 👲🏻 E1.0 person with skullcap: light skin tone";
## 1F472 1F3FC                                ; fully-qualified     # 👲🏼 E1.0 person with skullcap: medium-light skin tone # emoji-test.txt line #1487 Emoji version 13.0
is Uni.new(0x1F472, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F472, 0x1F3FC⟆ 👲🏼 E1.0 person with skullcap: medium-light skin tone";
## 1F472 1F3FD                                ; fully-qualified     # 👲🏽 E1.0 person with skullcap: medium skin tone # emoji-test.txt line #1488 Emoji version 13.0
is Uni.new(0x1F472, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F472, 0x1F3FD⟆ 👲🏽 E1.0 person with skullcap: medium skin tone";
## 1F472 1F3FE                                ; fully-qualified     # 👲🏾 E1.0 person with skullcap: medium-dark skin tone # emoji-test.txt line #1489 Emoji version 13.0
is Uni.new(0x1F472, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F472, 0x1F3FE⟆ 👲🏾 E1.0 person with skullcap: medium-dark skin tone";
## 1F472 1F3FF                                ; fully-qualified     # 👲🏿 E1.0 person with skullcap: dark skin tone # emoji-test.txt line #1490 Emoji version 13.0
is Uni.new(0x1F472, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F472, 0x1F3FF⟆ 👲🏿 E1.0 person with skullcap: dark skin tone";
## 1F9D5 1F3FB                                ; fully-qualified     # 🧕🏻 E5.0 woman with headscarf: light skin tone # emoji-test.txt line #1492 Emoji version 13.0
is Uni.new(0x1F9D5, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D5, 0x1F3FB⟆ 🧕🏻 E5.0 woman with headscarf: light skin tone";
## 1F9D5 1F3FC                                ; fully-qualified     # 🧕🏼 E5.0 woman with headscarf: medium-light skin tone # emoji-test.txt line #1493 Emoji version 13.0
is Uni.new(0x1F9D5, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D5, 0x1F3FC⟆ 🧕🏼 E5.0 woman with headscarf: medium-light skin tone";
## 1F9D5 1F3FD                                ; fully-qualified     # 🧕🏽 E5.0 woman with headscarf: medium skin tone # emoji-test.txt line #1494 Emoji version 13.0
is Uni.new(0x1F9D5, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D5, 0x1F3FD⟆ 🧕🏽 E5.0 woman with headscarf: medium skin tone";
## 1F9D5 1F3FE                                ; fully-qualified     # 🧕🏾 E5.0 woman with headscarf: medium-dark skin tone # emoji-test.txt line #1495 Emoji version 13.0
is Uni.new(0x1F9D5, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D5, 0x1F3FE⟆ 🧕🏾 E5.0 woman with headscarf: medium-dark skin tone";
## 1F9D5 1F3FF                                ; fully-qualified     # 🧕🏿 E5.0 woman with headscarf: dark skin tone # emoji-test.txt line #1496 Emoji version 13.0
is Uni.new(0x1F9D5, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D5, 0x1F3FF⟆ 🧕🏿 E5.0 woman with headscarf: dark skin tone";
## 1F935 1F3FB                                ; fully-qualified     # 🤵🏻 E3.0 person in tuxedo: light skin tone # emoji-test.txt line #1498 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FB⟆ 🤵🏻 E3.0 person in tuxedo: light skin tone";
## 1F935 1F3FC                                ; fully-qualified     # 🤵🏼 E3.0 person in tuxedo: medium-light skin tone # emoji-test.txt line #1499 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FC⟆ 🤵🏼 E3.0 person in tuxedo: medium-light skin tone";
## 1F935 1F3FD                                ; fully-qualified     # 🤵🏽 E3.0 person in tuxedo: medium skin tone # emoji-test.txt line #1500 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FD⟆ 🤵🏽 E3.0 person in tuxedo: medium skin tone";
## 1F935 1F3FE                                ; fully-qualified     # 🤵🏾 E3.0 person in tuxedo: medium-dark skin tone # emoji-test.txt line #1501 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FE⟆ 🤵🏾 E3.0 person in tuxedo: medium-dark skin tone";
## 1F935 1F3FF                                ; fully-qualified     # 🤵🏿 E3.0 person in tuxedo: dark skin tone # emoji-test.txt line #1502 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FF⟆ 🤵🏿 E3.0 person in tuxedo: dark skin tone";
## 1F935 200D 2642 FE0F                       ; fully-qualified     # 🤵‍♂️ E13.0 man in tuxedo # emoji-test.txt line #1503 Emoji version 13.0
is Uni.new(0x1F935, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x200D, 0x2642, 0xFE0F⟆ 🤵‍♂️ E13.0 man in tuxedo";
## 1F935 200D 2642                            ; minimally-qualified # 🤵‍♂ E13.0 man in tuxedo # emoji-test.txt line #1504 Emoji version 13.0
is Uni.new(0x1F935, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F935, 0x200D, 0x2642⟆ 🤵‍♂ E13.0 man in tuxedo";
## 1F935 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🤵🏻‍♂️ E13.0 man in tuxedo: light skin tone # emoji-test.txt line #1505 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🤵🏻‍♂️ E13.0 man in tuxedo: light skin tone";
## 1F935 1F3FB 200D 2642                      ; minimally-qualified # 🤵🏻‍♂ E13.0 man in tuxedo: light skin tone # emoji-test.txt line #1506 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FB, 0x200D, 0x2642⟆ 🤵🏻‍♂ E13.0 man in tuxedo: light skin tone";
## 1F935 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🤵🏼‍♂️ E13.0 man in tuxedo: medium-light skin tone # emoji-test.txt line #1507 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🤵🏼‍♂️ E13.0 man in tuxedo: medium-light skin tone";
## 1F935 1F3FC 200D 2642                      ; minimally-qualified # 🤵🏼‍♂ E13.0 man in tuxedo: medium-light skin tone # emoji-test.txt line #1508 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FC, 0x200D, 0x2642⟆ 🤵🏼‍♂ E13.0 man in tuxedo: medium-light skin tone";
## 1F935 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🤵🏽‍♂️ E13.0 man in tuxedo: medium skin tone # emoji-test.txt line #1509 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🤵🏽‍♂️ E13.0 man in tuxedo: medium skin tone";
## 1F935 1F3FD 200D 2642                      ; minimally-qualified # 🤵🏽‍♂ E13.0 man in tuxedo: medium skin tone # emoji-test.txt line #1510 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FD, 0x200D, 0x2642⟆ 🤵🏽‍♂ E13.0 man in tuxedo: medium skin tone";
## 1F935 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🤵🏾‍♂️ E13.0 man in tuxedo: medium-dark skin tone # emoji-test.txt line #1511 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🤵🏾‍♂️ E13.0 man in tuxedo: medium-dark skin tone";
## 1F935 1F3FE 200D 2642                      ; minimally-qualified # 🤵🏾‍♂ E13.0 man in tuxedo: medium-dark skin tone # emoji-test.txt line #1512 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FE, 0x200D, 0x2642⟆ 🤵🏾‍♂ E13.0 man in tuxedo: medium-dark skin tone";
## 1F935 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🤵🏿‍♂️ E13.0 man in tuxedo: dark skin tone # emoji-test.txt line #1513 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🤵🏿‍♂️ E13.0 man in tuxedo: dark skin tone";
## 1F935 1F3FF 200D 2642                      ; minimally-qualified # 🤵🏿‍♂ E13.0 man in tuxedo: dark skin tone # emoji-test.txt line #1514 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FF, 0x200D, 0x2642⟆ 🤵🏿‍♂ E13.0 man in tuxedo: dark skin tone";
## 1F935 200D 2640 FE0F                       ; fully-qualified     # 🤵‍♀️ E13.0 woman in tuxedo # emoji-test.txt line #1515 Emoji version 13.0
is Uni.new(0x1F935, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x200D, 0x2640, 0xFE0F⟆ 🤵‍♀️ E13.0 woman in tuxedo";
## 1F935 200D 2640                            ; minimally-qualified # 🤵‍♀ E13.0 woman in tuxedo # emoji-test.txt line #1516 Emoji version 13.0
is Uni.new(0x1F935, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F935, 0x200D, 0x2640⟆ 🤵‍♀ E13.0 woman in tuxedo";
## 1F935 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🤵🏻‍♀️ E13.0 woman in tuxedo: light skin tone # emoji-test.txt line #1517 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🤵🏻‍♀️ E13.0 woman in tuxedo: light skin tone";
## 1F935 1F3FB 200D 2640                      ; minimally-qualified # 🤵🏻‍♀ E13.0 woman in tuxedo: light skin tone # emoji-test.txt line #1518 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FB, 0x200D, 0x2640⟆ 🤵🏻‍♀ E13.0 woman in tuxedo: light skin tone";
## 1F935 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🤵🏼‍♀️ E13.0 woman in tuxedo: medium-light skin tone # emoji-test.txt line #1519 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🤵🏼‍♀️ E13.0 woman in tuxedo: medium-light skin tone";
## 1F935 1F3FC 200D 2640                      ; minimally-qualified # 🤵🏼‍♀ E13.0 woman in tuxedo: medium-light skin tone # emoji-test.txt line #1520 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FC, 0x200D, 0x2640⟆ 🤵🏼‍♀ E13.0 woman in tuxedo: medium-light skin tone";
## 1F935 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🤵🏽‍♀️ E13.0 woman in tuxedo: medium skin tone # emoji-test.txt line #1521 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🤵🏽‍♀️ E13.0 woman in tuxedo: medium skin tone";
## 1F935 1F3FD 200D 2640                      ; minimally-qualified # 🤵🏽‍♀ E13.0 woman in tuxedo: medium skin tone # emoji-test.txt line #1522 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FD, 0x200D, 0x2640⟆ 🤵🏽‍♀ E13.0 woman in tuxedo: medium skin tone";
## 1F935 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🤵🏾‍♀️ E13.0 woman in tuxedo: medium-dark skin tone # emoji-test.txt line #1523 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🤵🏾‍♀️ E13.0 woman in tuxedo: medium-dark skin tone";
## 1F935 1F3FE 200D 2640                      ; minimally-qualified # 🤵🏾‍♀ E13.0 woman in tuxedo: medium-dark skin tone # emoji-test.txt line #1524 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FE, 0x200D, 0x2640⟆ 🤵🏾‍♀ E13.0 woman in tuxedo: medium-dark skin tone";
## 1F935 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🤵🏿‍♀️ E13.0 woman in tuxedo: dark skin tone # emoji-test.txt line #1525 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🤵🏿‍♀️ E13.0 woman in tuxedo: dark skin tone";
## 1F935 1F3FF 200D 2640                      ; minimally-qualified # 🤵🏿‍♀ E13.0 woman in tuxedo: dark skin tone # emoji-test.txt line #1526 Emoji version 13.0
is Uni.new(0x1F935, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F935, 0x1F3FF, 0x200D, 0x2640⟆ 🤵🏿‍♀ E13.0 woman in tuxedo: dark skin tone";
## 1F470 1F3FB                                ; fully-qualified     # 👰🏻 E1.0 person with veil: light skin tone # emoji-test.txt line #1528 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FB⟆ 👰🏻 E1.0 person with veil: light skin tone";
## 1F470 1F3FC                                ; fully-qualified     # 👰🏼 E1.0 person with veil: medium-light skin tone # emoji-test.txt line #1529 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FC⟆ 👰🏼 E1.0 person with veil: medium-light skin tone";
## 1F470 1F3FD                                ; fully-qualified     # 👰🏽 E1.0 person with veil: medium skin tone # emoji-test.txt line #1530 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FD⟆ 👰🏽 E1.0 person with veil: medium skin tone";
## 1F470 1F3FE                                ; fully-qualified     # 👰🏾 E1.0 person with veil: medium-dark skin tone # emoji-test.txt line #1531 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FE⟆ 👰🏾 E1.0 person with veil: medium-dark skin tone";
## 1F470 1F3FF                                ; fully-qualified     # 👰🏿 E1.0 person with veil: dark skin tone # emoji-test.txt line #1532 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FF⟆ 👰🏿 E1.0 person with veil: dark skin tone";
## 1F470 200D 2642 FE0F                       ; fully-qualified     # 👰‍♂️ E13.0 man with veil # emoji-test.txt line #1533 Emoji version 13.0
is Uni.new(0x1F470, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x200D, 0x2642, 0xFE0F⟆ 👰‍♂️ E13.0 man with veil";
## 1F470 200D 2642                            ; minimally-qualified # 👰‍♂ E13.0 man with veil # emoji-test.txt line #1534 Emoji version 13.0
is Uni.new(0x1F470, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F470, 0x200D, 0x2642⟆ 👰‍♂ E13.0 man with veil";
## 1F470 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 👰🏻‍♂️ E13.0 man with veil: light skin tone # emoji-test.txt line #1535 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 👰🏻‍♂️ E13.0 man with veil: light skin tone";
## 1F470 1F3FB 200D 2642                      ; minimally-qualified # 👰🏻‍♂ E13.0 man with veil: light skin tone # emoji-test.txt line #1536 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FB, 0x200D, 0x2642⟆ 👰🏻‍♂ E13.0 man with veil: light skin tone";
## 1F470 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 👰🏼‍♂️ E13.0 man with veil: medium-light skin tone # emoji-test.txt line #1537 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 👰🏼‍♂️ E13.0 man with veil: medium-light skin tone";
## 1F470 1F3FC 200D 2642                      ; minimally-qualified # 👰🏼‍♂ E13.0 man with veil: medium-light skin tone # emoji-test.txt line #1538 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FC, 0x200D, 0x2642⟆ 👰🏼‍♂ E13.0 man with veil: medium-light skin tone";
## 1F470 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 👰🏽‍♂️ E13.0 man with veil: medium skin tone # emoji-test.txt line #1539 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 👰🏽‍♂️ E13.0 man with veil: medium skin tone";
## 1F470 1F3FD 200D 2642                      ; minimally-qualified # 👰🏽‍♂ E13.0 man with veil: medium skin tone # emoji-test.txt line #1540 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FD, 0x200D, 0x2642⟆ 👰🏽‍♂ E13.0 man with veil: medium skin tone";
## 1F470 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 👰🏾‍♂️ E13.0 man with veil: medium-dark skin tone # emoji-test.txt line #1541 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 👰🏾‍♂️ E13.0 man with veil: medium-dark skin tone";
## 1F470 1F3FE 200D 2642                      ; minimally-qualified # 👰🏾‍♂ E13.0 man with veil: medium-dark skin tone # emoji-test.txt line #1542 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FE, 0x200D, 0x2642⟆ 👰🏾‍♂ E13.0 man with veil: medium-dark skin tone";
## 1F470 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 👰🏿‍♂️ E13.0 man with veil: dark skin tone # emoji-test.txt line #1543 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 👰🏿‍♂️ E13.0 man with veil: dark skin tone";
## 1F470 1F3FF 200D 2642                      ; minimally-qualified # 👰🏿‍♂ E13.0 man with veil: dark skin tone # emoji-test.txt line #1544 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FF, 0x200D, 0x2642⟆ 👰🏿‍♂ E13.0 man with veil: dark skin tone";
## 1F470 200D 2640 FE0F                       ; fully-qualified     # 👰‍♀️ E13.0 woman with veil # emoji-test.txt line #1545 Emoji version 13.0
is Uni.new(0x1F470, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x200D, 0x2640, 0xFE0F⟆ 👰‍♀️ E13.0 woman with veil";
## 1F470 200D 2640                            ; minimally-qualified # 👰‍♀ E13.0 woman with veil # emoji-test.txt line #1546 Emoji version 13.0
is Uni.new(0x1F470, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F470, 0x200D, 0x2640⟆ 👰‍♀ E13.0 woman with veil";
## 1F470 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 👰🏻‍♀️ E13.0 woman with veil: light skin tone # emoji-test.txt line #1547 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 👰🏻‍♀️ E13.0 woman with veil: light skin tone";
## 1F470 1F3FB 200D 2640                      ; minimally-qualified # 👰🏻‍♀ E13.0 woman with veil: light skin tone # emoji-test.txt line #1548 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FB, 0x200D, 0x2640⟆ 👰🏻‍♀ E13.0 woman with veil: light skin tone";
## 1F470 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 👰🏼‍♀️ E13.0 woman with veil: medium-light skin tone # emoji-test.txt line #1549 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 👰🏼‍♀️ E13.0 woman with veil: medium-light skin tone";
## 1F470 1F3FC 200D 2640                      ; minimally-qualified # 👰🏼‍♀ E13.0 woman with veil: medium-light skin tone # emoji-test.txt line #1550 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FC, 0x200D, 0x2640⟆ 👰🏼‍♀ E13.0 woman with veil: medium-light skin tone";
## 1F470 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 👰🏽‍♀️ E13.0 woman with veil: medium skin tone # emoji-test.txt line #1551 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 👰🏽‍♀️ E13.0 woman with veil: medium skin tone";
## 1F470 1F3FD 200D 2640                      ; minimally-qualified # 👰🏽‍♀ E13.0 woman with veil: medium skin tone # emoji-test.txt line #1552 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FD, 0x200D, 0x2640⟆ 👰🏽‍♀ E13.0 woman with veil: medium skin tone";
## 1F470 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 👰🏾‍♀️ E13.0 woman with veil: medium-dark skin tone # emoji-test.txt line #1553 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 👰🏾‍♀️ E13.0 woman with veil: medium-dark skin tone";
## 1F470 1F3FE 200D 2640                      ; minimally-qualified # 👰🏾‍♀ E13.0 woman with veil: medium-dark skin tone # emoji-test.txt line #1554 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FE, 0x200D, 0x2640⟆ 👰🏾‍♀ E13.0 woman with veil: medium-dark skin tone";
## 1F470 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 👰🏿‍♀️ E13.0 woman with veil: dark skin tone # emoji-test.txt line #1555 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 👰🏿‍♀️ E13.0 woman with veil: dark skin tone";
## 1F470 1F3FF 200D 2640                      ; minimally-qualified # 👰🏿‍♀ E13.0 woman with veil: dark skin tone # emoji-test.txt line #1556 Emoji version 13.0
is Uni.new(0x1F470, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F470, 0x1F3FF, 0x200D, 0x2640⟆ 👰🏿‍♀ E13.0 woman with veil: dark skin tone";
## 1F930 1F3FB                                ; fully-qualified     # 🤰🏻 E3.0 pregnant woman: light skin tone # emoji-test.txt line #1558 Emoji version 13.0
is Uni.new(0x1F930, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F930, 0x1F3FB⟆ 🤰🏻 E3.0 pregnant woman: light skin tone";
## 1F930 1F3FC                                ; fully-qualified     # 🤰🏼 E3.0 pregnant woman: medium-light skin tone # emoji-test.txt line #1559 Emoji version 13.0
is Uni.new(0x1F930, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F930, 0x1F3FC⟆ 🤰🏼 E3.0 pregnant woman: medium-light skin tone";
## 1F930 1F3FD                                ; fully-qualified     # 🤰🏽 E3.0 pregnant woman: medium skin tone # emoji-test.txt line #1560 Emoji version 13.0
is Uni.new(0x1F930, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F930, 0x1F3FD⟆ 🤰🏽 E3.0 pregnant woman: medium skin tone";
## 1F930 1F3FE                                ; fully-qualified     # 🤰🏾 E3.0 pregnant woman: medium-dark skin tone # emoji-test.txt line #1561 Emoji version 13.0
is Uni.new(0x1F930, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F930, 0x1F3FE⟆ 🤰🏾 E3.0 pregnant woman: medium-dark skin tone";
## 1F930 1F3FF                                ; fully-qualified     # 🤰🏿 E3.0 pregnant woman: dark skin tone # emoji-test.txt line #1562 Emoji version 13.0
is Uni.new(0x1F930, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F930, 0x1F3FF⟆ 🤰🏿 E3.0 pregnant woman: dark skin tone";
## 1F931 1F3FB                                ; fully-qualified     # 🤱🏻 E5.0 breast-feeding: light skin tone # emoji-test.txt line #1564 Emoji version 13.0
is Uni.new(0x1F931, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F931, 0x1F3FB⟆ 🤱🏻 E5.0 breast-feeding: light skin tone";
## 1F931 1F3FC                                ; fully-qualified     # 🤱🏼 E5.0 breast-feeding: medium-light skin tone # emoji-test.txt line #1565 Emoji version 13.0
is Uni.new(0x1F931, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F931, 0x1F3FC⟆ 🤱🏼 E5.0 breast-feeding: medium-light skin tone";
## 1F931 1F3FD                                ; fully-qualified     # 🤱🏽 E5.0 breast-feeding: medium skin tone # emoji-test.txt line #1566 Emoji version 13.0
is Uni.new(0x1F931, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F931, 0x1F3FD⟆ 🤱🏽 E5.0 breast-feeding: medium skin tone";
## 1F931 1F3FE                                ; fully-qualified     # 🤱🏾 E5.0 breast-feeding: medium-dark skin tone # emoji-test.txt line #1567 Emoji version 13.0
is Uni.new(0x1F931, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F931, 0x1F3FE⟆ 🤱🏾 E5.0 breast-feeding: medium-dark skin tone";
## 1F931 1F3FF                                ; fully-qualified     # 🤱🏿 E5.0 breast-feeding: dark skin tone # emoji-test.txt line #1568 Emoji version 13.0
is Uni.new(0x1F931, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F931, 0x1F3FF⟆ 🤱🏿 E5.0 breast-feeding: dark skin tone";
## 1F469 200D 1F37C                           ; fully-qualified     # 👩‍🍼 E13.0 woman feeding baby # emoji-test.txt line #1569 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F37C⟆ 👩‍🍼 E13.0 woman feeding baby";
## 1F469 1F3FB 200D 1F37C                     ; fully-qualified     # 👩🏻‍🍼 E13.0 woman feeding baby: light skin tone # emoji-test.txt line #1570 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F37C⟆ 👩🏻‍🍼 E13.0 woman feeding baby: light skin tone";
## 1F469 1F3FC 200D 1F37C                     ; fully-qualified     # 👩🏼‍🍼 E13.0 woman feeding baby: medium-light skin tone # emoji-test.txt line #1571 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F37C⟆ 👩🏼‍🍼 E13.0 woman feeding baby: medium-light skin tone";
## 1F469 1F3FD 200D 1F37C                     ; fully-qualified     # 👩🏽‍🍼 E13.0 woman feeding baby: medium skin tone # emoji-test.txt line #1572 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F37C⟆ 👩🏽‍🍼 E13.0 woman feeding baby: medium skin tone";
## 1F469 1F3FE 200D 1F37C                     ; fully-qualified     # 👩🏾‍🍼 E13.0 woman feeding baby: medium-dark skin tone # emoji-test.txt line #1573 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F37C⟆ 👩🏾‍🍼 E13.0 woman feeding baby: medium-dark skin tone";
## 1F469 1F3FF 200D 1F37C                     ; fully-qualified     # 👩🏿‍🍼 E13.0 woman feeding baby: dark skin tone # emoji-test.txt line #1574 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F37C⟆ 👩🏿‍🍼 E13.0 woman feeding baby: dark skin tone";
## 1F468 200D 1F37C                           ; fully-qualified     # 👨‍🍼 E13.0 man feeding baby # emoji-test.txt line #1575 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F37C⟆ 👨‍🍼 E13.0 man feeding baby";
## 1F468 1F3FB 200D 1F37C                     ; fully-qualified     # 👨🏻‍🍼 E13.0 man feeding baby: light skin tone # emoji-test.txt line #1576 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F37C⟆ 👨🏻‍🍼 E13.0 man feeding baby: light skin tone";
## 1F468 1F3FC 200D 1F37C                     ; fully-qualified     # 👨🏼‍🍼 E13.0 man feeding baby: medium-light skin tone # emoji-test.txt line #1577 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F37C⟆ 👨🏼‍🍼 E13.0 man feeding baby: medium-light skin tone";
## 1F468 1F3FD 200D 1F37C                     ; fully-qualified     # 👨🏽‍🍼 E13.0 man feeding baby: medium skin tone # emoji-test.txt line #1578 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F37C⟆ 👨🏽‍🍼 E13.0 man feeding baby: medium skin tone";
## 1F468 1F3FE 200D 1F37C                     ; fully-qualified     # 👨🏾‍🍼 E13.0 man feeding baby: medium-dark skin tone # emoji-test.txt line #1579 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F37C⟆ 👨🏾‍🍼 E13.0 man feeding baby: medium-dark skin tone";
## 1F468 1F3FF 200D 1F37C                     ; fully-qualified     # 👨🏿‍🍼 E13.0 man feeding baby: dark skin tone # emoji-test.txt line #1580 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F37C⟆ 👨🏿‍🍼 E13.0 man feeding baby: dark skin tone";
## 1F9D1 200D 1F37C                           ; fully-qualified     # 🧑‍🍼 E13.0 person feeding baby # emoji-test.txt line #1581 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F37C⟆ 🧑‍🍼 E13.0 person feeding baby";
## 1F9D1 1F3FB 200D 1F37C                     ; fully-qualified     # 🧑🏻‍🍼 E13.0 person feeding baby: light skin tone # emoji-test.txt line #1582 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F37C⟆ 🧑🏻‍🍼 E13.0 person feeding baby: light skin tone";
## 1F9D1 1F3FC 200D 1F37C                     ; fully-qualified     # 🧑🏼‍🍼 E13.0 person feeding baby: medium-light skin tone # emoji-test.txt line #1583 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F37C⟆ 🧑🏼‍🍼 E13.0 person feeding baby: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F37C                     ; fully-qualified     # 🧑🏽‍🍼 E13.0 person feeding baby: medium skin tone # emoji-test.txt line #1584 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F37C⟆ 🧑🏽‍🍼 E13.0 person feeding baby: medium skin tone";
## 1F9D1 1F3FE 200D 1F37C                     ; fully-qualified     # 🧑🏾‍🍼 E13.0 person feeding baby: medium-dark skin tone # emoji-test.txt line #1585 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F37C⟆ 🧑🏾‍🍼 E13.0 person feeding baby: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F37C                     ; fully-qualified     # 🧑🏿‍🍼 E13.0 person feeding baby: dark skin tone # emoji-test.txt line #1586 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F37C).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F37C⟆ 🧑🏿‍🍼 E13.0 person feeding baby: dark skin tone";
## 1F47C 1F3FB                                ; fully-qualified     # 👼🏻 E1.0 baby angel: light skin tone # emoji-test.txt line #1590 Emoji version 13.0
is Uni.new(0x1F47C, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F47C, 0x1F3FB⟆ 👼🏻 E1.0 baby angel: light skin tone";
## 1F47C 1F3FC                                ; fully-qualified     # 👼🏼 E1.0 baby angel: medium-light skin tone # emoji-test.txt line #1591 Emoji version 13.0
is Uni.new(0x1F47C, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F47C, 0x1F3FC⟆ 👼🏼 E1.0 baby angel: medium-light skin tone";
## 1F47C 1F3FD                                ; fully-qualified     # 👼🏽 E1.0 baby angel: medium skin tone # emoji-test.txt line #1592 Emoji version 13.0
is Uni.new(0x1F47C, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F47C, 0x1F3FD⟆ 👼🏽 E1.0 baby angel: medium skin tone";
## 1F47C 1F3FE                                ; fully-qualified     # 👼🏾 E1.0 baby angel: medium-dark skin tone # emoji-test.txt line #1593 Emoji version 13.0
is Uni.new(0x1F47C, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F47C, 0x1F3FE⟆ 👼🏾 E1.0 baby angel: medium-dark skin tone";
## 1F47C 1F3FF                                ; fully-qualified     # 👼🏿 E1.0 baby angel: dark skin tone # emoji-test.txt line #1594 Emoji version 13.0
is Uni.new(0x1F47C, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F47C, 0x1F3FF⟆ 👼🏿 E1.0 baby angel: dark skin tone";
## 1F385 1F3FB                                ; fully-qualified     # 🎅🏻 E1.0 Santa Claus: light skin tone # emoji-test.txt line #1596 Emoji version 13.0
is Uni.new(0x1F385, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F385, 0x1F3FB⟆ 🎅🏻 E1.0 Santa Claus: light skin tone";
## 1F385 1F3FC                                ; fully-qualified     # 🎅🏼 E1.0 Santa Claus: medium-light skin tone # emoji-test.txt line #1597 Emoji version 13.0
is Uni.new(0x1F385, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F385, 0x1F3FC⟆ 🎅🏼 E1.0 Santa Claus: medium-light skin tone";
## 1F385 1F3FD                                ; fully-qualified     # 🎅🏽 E1.0 Santa Claus: medium skin tone # emoji-test.txt line #1598 Emoji version 13.0
is Uni.new(0x1F385, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F385, 0x1F3FD⟆ 🎅🏽 E1.0 Santa Claus: medium skin tone";
## 1F385 1F3FE                                ; fully-qualified     # 🎅🏾 E1.0 Santa Claus: medium-dark skin tone # emoji-test.txt line #1599 Emoji version 13.0
is Uni.new(0x1F385, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F385, 0x1F3FE⟆ 🎅🏾 E1.0 Santa Claus: medium-dark skin tone";
## 1F385 1F3FF                                ; fully-qualified     # 🎅🏿 E1.0 Santa Claus: dark skin tone # emoji-test.txt line #1600 Emoji version 13.0
is Uni.new(0x1F385, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F385, 0x1F3FF⟆ 🎅🏿 E1.0 Santa Claus: dark skin tone";
## 1F936 1F3FB                                ; fully-qualified     # 🤶🏻 E3.0 Mrs. Claus: light skin tone # emoji-test.txt line #1602 Emoji version 13.0
is Uni.new(0x1F936, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F936, 0x1F3FB⟆ 🤶🏻 E3.0 Mrs. Claus: light skin tone";
## 1F936 1F3FC                                ; fully-qualified     # 🤶🏼 E3.0 Mrs. Claus: medium-light skin tone # emoji-test.txt line #1603 Emoji version 13.0
is Uni.new(0x1F936, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F936, 0x1F3FC⟆ 🤶🏼 E3.0 Mrs. Claus: medium-light skin tone";
## 1F936 1F3FD                                ; fully-qualified     # 🤶🏽 E3.0 Mrs. Claus: medium skin tone # emoji-test.txt line #1604 Emoji version 13.0
is Uni.new(0x1F936, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F936, 0x1F3FD⟆ 🤶🏽 E3.0 Mrs. Claus: medium skin tone";
## 1F936 1F3FE                                ; fully-qualified     # 🤶🏾 E3.0 Mrs. Claus: medium-dark skin tone # emoji-test.txt line #1605 Emoji version 13.0
is Uni.new(0x1F936, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F936, 0x1F3FE⟆ 🤶🏾 E3.0 Mrs. Claus: medium-dark skin tone";
## 1F936 1F3FF                                ; fully-qualified     # 🤶🏿 E3.0 Mrs. Claus: dark skin tone # emoji-test.txt line #1606 Emoji version 13.0
is Uni.new(0x1F936, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F936, 0x1F3FF⟆ 🤶🏿 E3.0 Mrs. Claus: dark skin tone";
## 1F9D1 200D 1F384                           ; fully-qualified     # 🧑‍🎄 E13.0 mx claus # emoji-test.txt line #1607 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F384).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F384⟆ 🧑‍🎄 E13.0 mx claus";
## 1F9D1 1F3FB 200D 1F384                     ; fully-qualified     # 🧑🏻‍🎄 E13.0 mx claus: light skin tone # emoji-test.txt line #1608 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F384).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F384⟆ 🧑🏻‍🎄 E13.0 mx claus: light skin tone";
## 1F9D1 1F3FC 200D 1F384                     ; fully-qualified     # 🧑🏼‍🎄 E13.0 mx claus: medium-light skin tone # emoji-test.txt line #1609 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F384).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F384⟆ 🧑🏼‍🎄 E13.0 mx claus: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F384                     ; fully-qualified     # 🧑🏽‍🎄 E13.0 mx claus: medium skin tone # emoji-test.txt line #1610 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F384).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F384⟆ 🧑🏽‍🎄 E13.0 mx claus: medium skin tone";
## 1F9D1 1F3FE 200D 1F384                     ; fully-qualified     # 🧑🏾‍🎄 E13.0 mx claus: medium-dark skin tone # emoji-test.txt line #1611 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F384).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F384⟆ 🧑🏾‍🎄 E13.0 mx claus: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F384                     ; fully-qualified     # 🧑🏿‍🎄 E13.0 mx claus: dark skin tone # emoji-test.txt line #1612 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F384).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F384⟆ 🧑🏿‍🎄 E13.0 mx claus: dark skin tone";
## 1F9B8 1F3FB                                ; fully-qualified     # 🦸🏻 E11.0 superhero: light skin tone # emoji-test.txt line #1614 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FB⟆ 🦸🏻 E11.0 superhero: light skin tone";
## 1F9B8 1F3FC                                ; fully-qualified     # 🦸🏼 E11.0 superhero: medium-light skin tone # emoji-test.txt line #1615 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FC⟆ 🦸🏼 E11.0 superhero: medium-light skin tone";
## 1F9B8 1F3FD                                ; fully-qualified     # 🦸🏽 E11.0 superhero: medium skin tone # emoji-test.txt line #1616 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FD⟆ 🦸🏽 E11.0 superhero: medium skin tone";
## 1F9B8 1F3FE                                ; fully-qualified     # 🦸🏾 E11.0 superhero: medium-dark skin tone # emoji-test.txt line #1617 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FE⟆ 🦸🏾 E11.0 superhero: medium-dark skin tone";
## 1F9B8 1F3FF                                ; fully-qualified     # 🦸🏿 E11.0 superhero: dark skin tone # emoji-test.txt line #1618 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FF⟆ 🦸🏿 E11.0 superhero: dark skin tone";
## 1F9B8 200D 2642 FE0F                       ; fully-qualified     # 🦸‍♂️ E11.0 man superhero # emoji-test.txt line #1619 Emoji version 13.0
is Uni.new(0x1F9B8, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x200D, 0x2642, 0xFE0F⟆ 🦸‍♂️ E11.0 man superhero";
## 1F9B8 200D 2642                            ; minimally-qualified # 🦸‍♂ E11.0 man superhero # emoji-test.txt line #1620 Emoji version 13.0
is Uni.new(0x1F9B8, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x200D, 0x2642⟆ 🦸‍♂ E11.0 man superhero";
## 1F9B8 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🦸🏻‍♂️ E11.0 man superhero: light skin tone # emoji-test.txt line #1621 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🦸🏻‍♂️ E11.0 man superhero: light skin tone";
## 1F9B8 1F3FB 200D 2642                      ; minimally-qualified # 🦸🏻‍♂ E11.0 man superhero: light skin tone # emoji-test.txt line #1622 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FB, 0x200D, 0x2642⟆ 🦸🏻‍♂ E11.0 man superhero: light skin tone";
## 1F9B8 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🦸🏼‍♂️ E11.0 man superhero: medium-light skin tone # emoji-test.txt line #1623 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🦸🏼‍♂️ E11.0 man superhero: medium-light skin tone";
## 1F9B8 1F3FC 200D 2642                      ; minimally-qualified # 🦸🏼‍♂ E11.0 man superhero: medium-light skin tone # emoji-test.txt line #1624 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FC, 0x200D, 0x2642⟆ 🦸🏼‍♂ E11.0 man superhero: medium-light skin tone";
## 1F9B8 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🦸🏽‍♂️ E11.0 man superhero: medium skin tone # emoji-test.txt line #1625 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🦸🏽‍♂️ E11.0 man superhero: medium skin tone";
## 1F9B8 1F3FD 200D 2642                      ; minimally-qualified # 🦸🏽‍♂ E11.0 man superhero: medium skin tone # emoji-test.txt line #1626 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FD, 0x200D, 0x2642⟆ 🦸🏽‍♂ E11.0 man superhero: medium skin tone";
## 1F9B8 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🦸🏾‍♂️ E11.0 man superhero: medium-dark skin tone # emoji-test.txt line #1627 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🦸🏾‍♂️ E11.0 man superhero: medium-dark skin tone";
## 1F9B8 1F3FE 200D 2642                      ; minimally-qualified # 🦸🏾‍♂ E11.0 man superhero: medium-dark skin tone # emoji-test.txt line #1628 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FE, 0x200D, 0x2642⟆ 🦸🏾‍♂ E11.0 man superhero: medium-dark skin tone";
## 1F9B8 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🦸🏿‍♂️ E11.0 man superhero: dark skin tone # emoji-test.txt line #1629 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🦸🏿‍♂️ E11.0 man superhero: dark skin tone";
## 1F9B8 1F3FF 200D 2642                      ; minimally-qualified # 🦸🏿‍♂ E11.0 man superhero: dark skin tone # emoji-test.txt line #1630 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FF, 0x200D, 0x2642⟆ 🦸🏿‍♂ E11.0 man superhero: dark skin tone";
## 1F9B8 200D 2640 FE0F                       ; fully-qualified     # 🦸‍♀️ E11.0 woman superhero # emoji-test.txt line #1631 Emoji version 13.0
is Uni.new(0x1F9B8, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x200D, 0x2640, 0xFE0F⟆ 🦸‍♀️ E11.0 woman superhero";
## 1F9B8 200D 2640                            ; minimally-qualified # 🦸‍♀ E11.0 woman superhero # emoji-test.txt line #1632 Emoji version 13.0
is Uni.new(0x1F9B8, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x200D, 0x2640⟆ 🦸‍♀ E11.0 woman superhero";
## 1F9B8 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🦸🏻‍♀️ E11.0 woman superhero: light skin tone # emoji-test.txt line #1633 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🦸🏻‍♀️ E11.0 woman superhero: light skin tone";
## 1F9B8 1F3FB 200D 2640                      ; minimally-qualified # 🦸🏻‍♀ E11.0 woman superhero: light skin tone # emoji-test.txt line #1634 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FB, 0x200D, 0x2640⟆ 🦸🏻‍♀ E11.0 woman superhero: light skin tone";
## 1F9B8 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🦸🏼‍♀️ E11.0 woman superhero: medium-light skin tone # emoji-test.txt line #1635 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🦸🏼‍♀️ E11.0 woman superhero: medium-light skin tone";
## 1F9B8 1F3FC 200D 2640                      ; minimally-qualified # 🦸🏼‍♀ E11.0 woman superhero: medium-light skin tone # emoji-test.txt line #1636 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FC, 0x200D, 0x2640⟆ 🦸🏼‍♀ E11.0 woman superhero: medium-light skin tone";
## 1F9B8 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🦸🏽‍♀️ E11.0 woman superhero: medium skin tone # emoji-test.txt line #1637 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🦸🏽‍♀️ E11.0 woman superhero: medium skin tone";
## 1F9B8 1F3FD 200D 2640                      ; minimally-qualified # 🦸🏽‍♀ E11.0 woman superhero: medium skin tone # emoji-test.txt line #1638 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FD, 0x200D, 0x2640⟆ 🦸🏽‍♀ E11.0 woman superhero: medium skin tone";
## 1F9B8 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🦸🏾‍♀️ E11.0 woman superhero: medium-dark skin tone # emoji-test.txt line #1639 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🦸🏾‍♀️ E11.0 woman superhero: medium-dark skin tone";
## 1F9B8 1F3FE 200D 2640                      ; minimally-qualified # 🦸🏾‍♀ E11.0 woman superhero: medium-dark skin tone # emoji-test.txt line #1640 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FE, 0x200D, 0x2640⟆ 🦸🏾‍♀ E11.0 woman superhero: medium-dark skin tone";
## 1F9B8 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🦸🏿‍♀️ E11.0 woman superhero: dark skin tone # emoji-test.txt line #1641 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🦸🏿‍♀️ E11.0 woman superhero: dark skin tone";
## 1F9B8 1F3FF 200D 2640                      ; minimally-qualified # 🦸🏿‍♀ E11.0 woman superhero: dark skin tone # emoji-test.txt line #1642 Emoji version 13.0
is Uni.new(0x1F9B8, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B8, 0x1F3FF, 0x200D, 0x2640⟆ 🦸🏿‍♀ E11.0 woman superhero: dark skin tone";
## 1F9B9 1F3FB                                ; fully-qualified     # 🦹🏻 E11.0 supervillain: light skin tone # emoji-test.txt line #1644 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FB⟆ 🦹🏻 E11.0 supervillain: light skin tone";
## 1F9B9 1F3FC                                ; fully-qualified     # 🦹🏼 E11.0 supervillain: medium-light skin tone # emoji-test.txt line #1645 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FC⟆ 🦹🏼 E11.0 supervillain: medium-light skin tone";
## 1F9B9 1F3FD                                ; fully-qualified     # 🦹🏽 E11.0 supervillain: medium skin tone # emoji-test.txt line #1646 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FD⟆ 🦹🏽 E11.0 supervillain: medium skin tone";
## 1F9B9 1F3FE                                ; fully-qualified     # 🦹🏾 E11.0 supervillain: medium-dark skin tone # emoji-test.txt line #1647 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FE⟆ 🦹🏾 E11.0 supervillain: medium-dark skin tone";
## 1F9B9 1F3FF                                ; fully-qualified     # 🦹🏿 E11.0 supervillain: dark skin tone # emoji-test.txt line #1648 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FF⟆ 🦹🏿 E11.0 supervillain: dark skin tone";
## 1F9B9 200D 2642 FE0F                       ; fully-qualified     # 🦹‍♂️ E11.0 man supervillain # emoji-test.txt line #1649 Emoji version 13.0
is Uni.new(0x1F9B9, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x200D, 0x2642, 0xFE0F⟆ 🦹‍♂️ E11.0 man supervillain";
## 1F9B9 200D 2642                            ; minimally-qualified # 🦹‍♂ E11.0 man supervillain # emoji-test.txt line #1650 Emoji version 13.0
is Uni.new(0x1F9B9, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x200D, 0x2642⟆ 🦹‍♂ E11.0 man supervillain";
## 1F9B9 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🦹🏻‍♂️ E11.0 man supervillain: light skin tone # emoji-test.txt line #1651 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🦹🏻‍♂️ E11.0 man supervillain: light skin tone";
## 1F9B9 1F3FB 200D 2642                      ; minimally-qualified # 🦹🏻‍♂ E11.0 man supervillain: light skin tone # emoji-test.txt line #1652 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FB, 0x200D, 0x2642⟆ 🦹🏻‍♂ E11.0 man supervillain: light skin tone";
## 1F9B9 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🦹🏼‍♂️ E11.0 man supervillain: medium-light skin tone # emoji-test.txt line #1653 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🦹🏼‍♂️ E11.0 man supervillain: medium-light skin tone";
## 1F9B9 1F3FC 200D 2642                      ; minimally-qualified # 🦹🏼‍♂ E11.0 man supervillain: medium-light skin tone # emoji-test.txt line #1654 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FC, 0x200D, 0x2642⟆ 🦹🏼‍♂ E11.0 man supervillain: medium-light skin tone";
## 1F9B9 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🦹🏽‍♂️ E11.0 man supervillain: medium skin tone # emoji-test.txt line #1655 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🦹🏽‍♂️ E11.0 man supervillain: medium skin tone";
## 1F9B9 1F3FD 200D 2642                      ; minimally-qualified # 🦹🏽‍♂ E11.0 man supervillain: medium skin tone # emoji-test.txt line #1656 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FD, 0x200D, 0x2642⟆ 🦹🏽‍♂ E11.0 man supervillain: medium skin tone";
## 1F9B9 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🦹🏾‍♂️ E11.0 man supervillain: medium-dark skin tone # emoji-test.txt line #1657 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🦹🏾‍♂️ E11.0 man supervillain: medium-dark skin tone";
## 1F9B9 1F3FE 200D 2642                      ; minimally-qualified # 🦹🏾‍♂ E11.0 man supervillain: medium-dark skin tone # emoji-test.txt line #1658 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FE, 0x200D, 0x2642⟆ 🦹🏾‍♂ E11.0 man supervillain: medium-dark skin tone";
## 1F9B9 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🦹🏿‍♂️ E11.0 man supervillain: dark skin tone # emoji-test.txt line #1659 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🦹🏿‍♂️ E11.0 man supervillain: dark skin tone";
## 1F9B9 1F3FF 200D 2642                      ; minimally-qualified # 🦹🏿‍♂ E11.0 man supervillain: dark skin tone # emoji-test.txt line #1660 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FF, 0x200D, 0x2642⟆ 🦹🏿‍♂ E11.0 man supervillain: dark skin tone";
## 1F9B9 200D 2640 FE0F                       ; fully-qualified     # 🦹‍♀️ E11.0 woman supervillain # emoji-test.txt line #1661 Emoji version 13.0
is Uni.new(0x1F9B9, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x200D, 0x2640, 0xFE0F⟆ 🦹‍♀️ E11.0 woman supervillain";
## 1F9B9 200D 2640                            ; minimally-qualified # 🦹‍♀ E11.0 woman supervillain # emoji-test.txt line #1662 Emoji version 13.0
is Uni.new(0x1F9B9, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x200D, 0x2640⟆ 🦹‍♀ E11.0 woman supervillain";
## 1F9B9 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🦹🏻‍♀️ E11.0 woman supervillain: light skin tone # emoji-test.txt line #1663 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🦹🏻‍♀️ E11.0 woman supervillain: light skin tone";
## 1F9B9 1F3FB 200D 2640                      ; minimally-qualified # 🦹🏻‍♀ E11.0 woman supervillain: light skin tone # emoji-test.txt line #1664 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FB, 0x200D, 0x2640⟆ 🦹🏻‍♀ E11.0 woman supervillain: light skin tone";
## 1F9B9 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🦹🏼‍♀️ E11.0 woman supervillain: medium-light skin tone # emoji-test.txt line #1665 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🦹🏼‍♀️ E11.0 woman supervillain: medium-light skin tone";
## 1F9B9 1F3FC 200D 2640                      ; minimally-qualified # 🦹🏼‍♀ E11.0 woman supervillain: medium-light skin tone # emoji-test.txt line #1666 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FC, 0x200D, 0x2640⟆ 🦹🏼‍♀ E11.0 woman supervillain: medium-light skin tone";
## 1F9B9 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🦹🏽‍♀️ E11.0 woman supervillain: medium skin tone # emoji-test.txt line #1667 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🦹🏽‍♀️ E11.0 woman supervillain: medium skin tone";
## 1F9B9 1F3FD 200D 2640                      ; minimally-qualified # 🦹🏽‍♀ E11.0 woman supervillain: medium skin tone # emoji-test.txt line #1668 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FD, 0x200D, 0x2640⟆ 🦹🏽‍♀ E11.0 woman supervillain: medium skin tone";
## 1F9B9 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🦹🏾‍♀️ E11.0 woman supervillain: medium-dark skin tone # emoji-test.txt line #1669 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🦹🏾‍♀️ E11.0 woman supervillain: medium-dark skin tone";
## 1F9B9 1F3FE 200D 2640                      ; minimally-qualified # 🦹🏾‍♀ E11.0 woman supervillain: medium-dark skin tone # emoji-test.txt line #1670 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FE, 0x200D, 0x2640⟆ 🦹🏾‍♀ E11.0 woman supervillain: medium-dark skin tone";
## 1F9B9 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🦹🏿‍♀️ E11.0 woman supervillain: dark skin tone # emoji-test.txt line #1671 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🦹🏿‍♀️ E11.0 woman supervillain: dark skin tone";
## 1F9B9 1F3FF 200D 2640                      ; minimally-qualified # 🦹🏿‍♀ E11.0 woman supervillain: dark skin tone # emoji-test.txt line #1672 Emoji version 13.0
is Uni.new(0x1F9B9, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9B9, 0x1F3FF, 0x200D, 0x2640⟆ 🦹🏿‍♀ E11.0 woman supervillain: dark skin tone";
## 1F9D9 1F3FB                                ; fully-qualified     # 🧙🏻 E5.0 mage: light skin tone # emoji-test.txt line #1674 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FB⟆ 🧙🏻 E5.0 mage: light skin tone";
## 1F9D9 1F3FC                                ; fully-qualified     # 🧙🏼 E5.0 mage: medium-light skin tone # emoji-test.txt line #1675 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FC⟆ 🧙🏼 E5.0 mage: medium-light skin tone";
## 1F9D9 1F3FD                                ; fully-qualified     # 🧙🏽 E5.0 mage: medium skin tone # emoji-test.txt line #1676 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FD⟆ 🧙🏽 E5.0 mage: medium skin tone";
## 1F9D9 1F3FE                                ; fully-qualified     # 🧙🏾 E5.0 mage: medium-dark skin tone # emoji-test.txt line #1677 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FE⟆ 🧙🏾 E5.0 mage: medium-dark skin tone";
## 1F9D9 1F3FF                                ; fully-qualified     # 🧙🏿 E5.0 mage: dark skin tone # emoji-test.txt line #1678 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FF⟆ 🧙🏿 E5.0 mage: dark skin tone";
## 1F9D9 200D 2642 FE0F                       ; fully-qualified     # 🧙‍♂️ E5.0 man mage # emoji-test.txt line #1679 Emoji version 13.0
is Uni.new(0x1F9D9, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x200D, 0x2642, 0xFE0F⟆ 🧙‍♂️ E5.0 man mage";
## 1F9D9 200D 2642                            ; minimally-qualified # 🧙‍♂ E5.0 man mage # emoji-test.txt line #1680 Emoji version 13.0
is Uni.new(0x1F9D9, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x200D, 0x2642⟆ 🧙‍♂ E5.0 man mage";
## 1F9D9 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧙🏻‍♂️ E5.0 man mage: light skin tone # emoji-test.txt line #1681 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧙🏻‍♂️ E5.0 man mage: light skin tone";
## 1F9D9 1F3FB 200D 2642                      ; minimally-qualified # 🧙🏻‍♂ E5.0 man mage: light skin tone # emoji-test.txt line #1682 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FB, 0x200D, 0x2642⟆ 🧙🏻‍♂ E5.0 man mage: light skin tone";
## 1F9D9 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧙🏼‍♂️ E5.0 man mage: medium-light skin tone # emoji-test.txt line #1683 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧙🏼‍♂️ E5.0 man mage: medium-light skin tone";
## 1F9D9 1F3FC 200D 2642                      ; minimally-qualified # 🧙🏼‍♂ E5.0 man mage: medium-light skin tone # emoji-test.txt line #1684 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FC, 0x200D, 0x2642⟆ 🧙🏼‍♂ E5.0 man mage: medium-light skin tone";
## 1F9D9 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧙🏽‍♂️ E5.0 man mage: medium skin tone # emoji-test.txt line #1685 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧙🏽‍♂️ E5.0 man mage: medium skin tone";
## 1F9D9 1F3FD 200D 2642                      ; minimally-qualified # 🧙🏽‍♂ E5.0 man mage: medium skin tone # emoji-test.txt line #1686 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FD, 0x200D, 0x2642⟆ 🧙🏽‍♂ E5.0 man mage: medium skin tone";
## 1F9D9 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧙🏾‍♂️ E5.0 man mage: medium-dark skin tone # emoji-test.txt line #1687 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧙🏾‍♂️ E5.0 man mage: medium-dark skin tone";
## 1F9D9 1F3FE 200D 2642                      ; minimally-qualified # 🧙🏾‍♂ E5.0 man mage: medium-dark skin tone # emoji-test.txt line #1688 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FE, 0x200D, 0x2642⟆ 🧙🏾‍♂ E5.0 man mage: medium-dark skin tone";
## 1F9D9 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧙🏿‍♂️ E5.0 man mage: dark skin tone # emoji-test.txt line #1689 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧙🏿‍♂️ E5.0 man mage: dark skin tone";
## 1F9D9 1F3FF 200D 2642                      ; minimally-qualified # 🧙🏿‍♂ E5.0 man mage: dark skin tone # emoji-test.txt line #1690 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FF, 0x200D, 0x2642⟆ 🧙🏿‍♂ E5.0 man mage: dark skin tone";
## 1F9D9 200D 2640 FE0F                       ; fully-qualified     # 🧙‍♀️ E5.0 woman mage # emoji-test.txt line #1691 Emoji version 13.0
is Uni.new(0x1F9D9, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x200D, 0x2640, 0xFE0F⟆ 🧙‍♀️ E5.0 woman mage";
## 1F9D9 200D 2640                            ; minimally-qualified # 🧙‍♀ E5.0 woman mage # emoji-test.txt line #1692 Emoji version 13.0
is Uni.new(0x1F9D9, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x200D, 0x2640⟆ 🧙‍♀ E5.0 woman mage";
## 1F9D9 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧙🏻‍♀️ E5.0 woman mage: light skin tone # emoji-test.txt line #1693 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧙🏻‍♀️ E5.0 woman mage: light skin tone";
## 1F9D9 1F3FB 200D 2640                      ; minimally-qualified # 🧙🏻‍♀ E5.0 woman mage: light skin tone # emoji-test.txt line #1694 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FB, 0x200D, 0x2640⟆ 🧙🏻‍♀ E5.0 woman mage: light skin tone";
## 1F9D9 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧙🏼‍♀️ E5.0 woman mage: medium-light skin tone # emoji-test.txt line #1695 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧙🏼‍♀️ E5.0 woman mage: medium-light skin tone";
## 1F9D9 1F3FC 200D 2640                      ; minimally-qualified # 🧙🏼‍♀ E5.0 woman mage: medium-light skin tone # emoji-test.txt line #1696 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FC, 0x200D, 0x2640⟆ 🧙🏼‍♀ E5.0 woman mage: medium-light skin tone";
## 1F9D9 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧙🏽‍♀️ E5.0 woman mage: medium skin tone # emoji-test.txt line #1697 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧙🏽‍♀️ E5.0 woman mage: medium skin tone";
## 1F9D9 1F3FD 200D 2640                      ; minimally-qualified # 🧙🏽‍♀ E5.0 woman mage: medium skin tone # emoji-test.txt line #1698 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FD, 0x200D, 0x2640⟆ 🧙🏽‍♀ E5.0 woman mage: medium skin tone";
## 1F9D9 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧙🏾‍♀️ E5.0 woman mage: medium-dark skin tone # emoji-test.txt line #1699 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧙🏾‍♀️ E5.0 woman mage: medium-dark skin tone";
## 1F9D9 1F3FE 200D 2640                      ; minimally-qualified # 🧙🏾‍♀ E5.0 woman mage: medium-dark skin tone # emoji-test.txt line #1700 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FE, 0x200D, 0x2640⟆ 🧙🏾‍♀ E5.0 woman mage: medium-dark skin tone";
## 1F9D9 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧙🏿‍♀️ E5.0 woman mage: dark skin tone # emoji-test.txt line #1701 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧙🏿‍♀️ E5.0 woman mage: dark skin tone";
## 1F9D9 1F3FF 200D 2640                      ; minimally-qualified # 🧙🏿‍♀ E5.0 woman mage: dark skin tone # emoji-test.txt line #1702 Emoji version 13.0
is Uni.new(0x1F9D9, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D9, 0x1F3FF, 0x200D, 0x2640⟆ 🧙🏿‍♀ E5.0 woman mage: dark skin tone";
## 1F9DA 1F3FB                                ; fully-qualified     # 🧚🏻 E5.0 fairy: light skin tone # emoji-test.txt line #1704 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FB⟆ 🧚🏻 E5.0 fairy: light skin tone";
## 1F9DA 1F3FC                                ; fully-qualified     # 🧚🏼 E5.0 fairy: medium-light skin tone # emoji-test.txt line #1705 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FC⟆ 🧚🏼 E5.0 fairy: medium-light skin tone";
## 1F9DA 1F3FD                                ; fully-qualified     # 🧚🏽 E5.0 fairy: medium skin tone # emoji-test.txt line #1706 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FD⟆ 🧚🏽 E5.0 fairy: medium skin tone";
## 1F9DA 1F3FE                                ; fully-qualified     # 🧚🏾 E5.0 fairy: medium-dark skin tone # emoji-test.txt line #1707 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FE⟆ 🧚🏾 E5.0 fairy: medium-dark skin tone";
## 1F9DA 1F3FF                                ; fully-qualified     # 🧚🏿 E5.0 fairy: dark skin tone # emoji-test.txt line #1708 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FF⟆ 🧚🏿 E5.0 fairy: dark skin tone";
## 1F9DA 200D 2642 FE0F                       ; fully-qualified     # 🧚‍♂️ E5.0 man fairy # emoji-test.txt line #1709 Emoji version 13.0
is Uni.new(0x1F9DA, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x200D, 0x2642, 0xFE0F⟆ 🧚‍♂️ E5.0 man fairy";
## 1F9DA 200D 2642                            ; minimally-qualified # 🧚‍♂ E5.0 man fairy # emoji-test.txt line #1710 Emoji version 13.0
is Uni.new(0x1F9DA, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x200D, 0x2642⟆ 🧚‍♂ E5.0 man fairy";
## 1F9DA 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧚🏻‍♂️ E5.0 man fairy: light skin tone # emoji-test.txt line #1711 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧚🏻‍♂️ E5.0 man fairy: light skin tone";
## 1F9DA 1F3FB 200D 2642                      ; minimally-qualified # 🧚🏻‍♂ E5.0 man fairy: light skin tone # emoji-test.txt line #1712 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FB, 0x200D, 0x2642⟆ 🧚🏻‍♂ E5.0 man fairy: light skin tone";
## 1F9DA 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧚🏼‍♂️ E5.0 man fairy: medium-light skin tone # emoji-test.txt line #1713 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧚🏼‍♂️ E5.0 man fairy: medium-light skin tone";
## 1F9DA 1F3FC 200D 2642                      ; minimally-qualified # 🧚🏼‍♂ E5.0 man fairy: medium-light skin tone # emoji-test.txt line #1714 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FC, 0x200D, 0x2642⟆ 🧚🏼‍♂ E5.0 man fairy: medium-light skin tone";
## 1F9DA 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧚🏽‍♂️ E5.0 man fairy: medium skin tone # emoji-test.txt line #1715 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧚🏽‍♂️ E5.0 man fairy: medium skin tone";
## 1F9DA 1F3FD 200D 2642                      ; minimally-qualified # 🧚🏽‍♂ E5.0 man fairy: medium skin tone # emoji-test.txt line #1716 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FD, 0x200D, 0x2642⟆ 🧚🏽‍♂ E5.0 man fairy: medium skin tone";
## 1F9DA 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧚🏾‍♂️ E5.0 man fairy: medium-dark skin tone # emoji-test.txt line #1717 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧚🏾‍♂️ E5.0 man fairy: medium-dark skin tone";
## 1F9DA 1F3FE 200D 2642                      ; minimally-qualified # 🧚🏾‍♂ E5.0 man fairy: medium-dark skin tone # emoji-test.txt line #1718 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FE, 0x200D, 0x2642⟆ 🧚🏾‍♂ E5.0 man fairy: medium-dark skin tone";
## 1F9DA 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧚🏿‍♂️ E5.0 man fairy: dark skin tone # emoji-test.txt line #1719 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧚🏿‍♂️ E5.0 man fairy: dark skin tone";
## 1F9DA 1F3FF 200D 2642                      ; minimally-qualified # 🧚🏿‍♂ E5.0 man fairy: dark skin tone # emoji-test.txt line #1720 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FF, 0x200D, 0x2642⟆ 🧚🏿‍♂ E5.0 man fairy: dark skin tone";
## 1F9DA 200D 2640 FE0F                       ; fully-qualified     # 🧚‍♀️ E5.0 woman fairy # emoji-test.txt line #1721 Emoji version 13.0
is Uni.new(0x1F9DA, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x200D, 0x2640, 0xFE0F⟆ 🧚‍♀️ E5.0 woman fairy";
## 1F9DA 200D 2640                            ; minimally-qualified # 🧚‍♀ E5.0 woman fairy # emoji-test.txt line #1722 Emoji version 13.0
is Uni.new(0x1F9DA, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x200D, 0x2640⟆ 🧚‍♀ E5.0 woman fairy";
## 1F9DA 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧚🏻‍♀️ E5.0 woman fairy: light skin tone # emoji-test.txt line #1723 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧚🏻‍♀️ E5.0 woman fairy: light skin tone";
## 1F9DA 1F3FB 200D 2640                      ; minimally-qualified # 🧚🏻‍♀ E5.0 woman fairy: light skin tone # emoji-test.txt line #1724 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FB, 0x200D, 0x2640⟆ 🧚🏻‍♀ E5.0 woman fairy: light skin tone";
## 1F9DA 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧚🏼‍♀️ E5.0 woman fairy: medium-light skin tone # emoji-test.txt line #1725 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧚🏼‍♀️ E5.0 woman fairy: medium-light skin tone";
## 1F9DA 1F3FC 200D 2640                      ; minimally-qualified # 🧚🏼‍♀ E5.0 woman fairy: medium-light skin tone # emoji-test.txt line #1726 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FC, 0x200D, 0x2640⟆ 🧚🏼‍♀ E5.0 woman fairy: medium-light skin tone";
## 1F9DA 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧚🏽‍♀️ E5.0 woman fairy: medium skin tone # emoji-test.txt line #1727 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧚🏽‍♀️ E5.0 woman fairy: medium skin tone";
## 1F9DA 1F3FD 200D 2640                      ; minimally-qualified # 🧚🏽‍♀ E5.0 woman fairy: medium skin tone # emoji-test.txt line #1728 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FD, 0x200D, 0x2640⟆ 🧚🏽‍♀ E5.0 woman fairy: medium skin tone";
## 1F9DA 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧚🏾‍♀️ E5.0 woman fairy: medium-dark skin tone # emoji-test.txt line #1729 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧚🏾‍♀️ E5.0 woman fairy: medium-dark skin tone";
## 1F9DA 1F3FE 200D 2640                      ; minimally-qualified # 🧚🏾‍♀ E5.0 woman fairy: medium-dark skin tone # emoji-test.txt line #1730 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FE, 0x200D, 0x2640⟆ 🧚🏾‍♀ E5.0 woman fairy: medium-dark skin tone";
## 1F9DA 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧚🏿‍♀️ E5.0 woman fairy: dark skin tone # emoji-test.txt line #1731 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧚🏿‍♀️ E5.0 woman fairy: dark skin tone";
## 1F9DA 1F3FF 200D 2640                      ; minimally-qualified # 🧚🏿‍♀ E5.0 woman fairy: dark skin tone # emoji-test.txt line #1732 Emoji version 13.0
is Uni.new(0x1F9DA, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DA, 0x1F3FF, 0x200D, 0x2640⟆ 🧚🏿‍♀ E5.0 woman fairy: dark skin tone";
## 1F9DB 1F3FB                                ; fully-qualified     # 🧛🏻 E5.0 vampire: light skin tone # emoji-test.txt line #1734 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FB⟆ 🧛🏻 E5.0 vampire: light skin tone";
## 1F9DB 1F3FC                                ; fully-qualified     # 🧛🏼 E5.0 vampire: medium-light skin tone # emoji-test.txt line #1735 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FC⟆ 🧛🏼 E5.0 vampire: medium-light skin tone";
## 1F9DB 1F3FD                                ; fully-qualified     # 🧛🏽 E5.0 vampire: medium skin tone # emoji-test.txt line #1736 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FD⟆ 🧛🏽 E5.0 vampire: medium skin tone";
## 1F9DB 1F3FE                                ; fully-qualified     # 🧛🏾 E5.0 vampire: medium-dark skin tone # emoji-test.txt line #1737 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FE⟆ 🧛🏾 E5.0 vampire: medium-dark skin tone";
## 1F9DB 1F3FF                                ; fully-qualified     # 🧛🏿 E5.0 vampire: dark skin tone # emoji-test.txt line #1738 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FF⟆ 🧛🏿 E5.0 vampire: dark skin tone";
## 1F9DB 200D 2642 FE0F                       ; fully-qualified     # 🧛‍♂️ E5.0 man vampire # emoji-test.txt line #1739 Emoji version 13.0
is Uni.new(0x1F9DB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x200D, 0x2642, 0xFE0F⟆ 🧛‍♂️ E5.0 man vampire";
## 1F9DB 200D 2642                            ; minimally-qualified # 🧛‍♂ E5.0 man vampire # emoji-test.txt line #1740 Emoji version 13.0
is Uni.new(0x1F9DB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x200D, 0x2642⟆ 🧛‍♂ E5.0 man vampire";
## 1F9DB 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧛🏻‍♂️ E5.0 man vampire: light skin tone # emoji-test.txt line #1741 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧛🏻‍♂️ E5.0 man vampire: light skin tone";
## 1F9DB 1F3FB 200D 2642                      ; minimally-qualified # 🧛🏻‍♂ E5.0 man vampire: light skin tone # emoji-test.txt line #1742 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FB, 0x200D, 0x2642⟆ 🧛🏻‍♂ E5.0 man vampire: light skin tone";
## 1F9DB 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧛🏼‍♂️ E5.0 man vampire: medium-light skin tone # emoji-test.txt line #1743 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧛🏼‍♂️ E5.0 man vampire: medium-light skin tone";
## 1F9DB 1F3FC 200D 2642                      ; minimally-qualified # 🧛🏼‍♂ E5.0 man vampire: medium-light skin tone # emoji-test.txt line #1744 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FC, 0x200D, 0x2642⟆ 🧛🏼‍♂ E5.0 man vampire: medium-light skin tone";
## 1F9DB 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧛🏽‍♂️ E5.0 man vampire: medium skin tone # emoji-test.txt line #1745 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧛🏽‍♂️ E5.0 man vampire: medium skin tone";
## 1F9DB 1F3FD 200D 2642                      ; minimally-qualified # 🧛🏽‍♂ E5.0 man vampire: medium skin tone # emoji-test.txt line #1746 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FD, 0x200D, 0x2642⟆ 🧛🏽‍♂ E5.0 man vampire: medium skin tone";
## 1F9DB 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧛🏾‍♂️ E5.0 man vampire: medium-dark skin tone # emoji-test.txt line #1747 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧛🏾‍♂️ E5.0 man vampire: medium-dark skin tone";
## 1F9DB 1F3FE 200D 2642                      ; minimally-qualified # 🧛🏾‍♂ E5.0 man vampire: medium-dark skin tone # emoji-test.txt line #1748 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FE, 0x200D, 0x2642⟆ 🧛🏾‍♂ E5.0 man vampire: medium-dark skin tone";
## 1F9DB 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧛🏿‍♂️ E5.0 man vampire: dark skin tone # emoji-test.txt line #1749 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧛🏿‍♂️ E5.0 man vampire: dark skin tone";
## 1F9DB 1F3FF 200D 2642                      ; minimally-qualified # 🧛🏿‍♂ E5.0 man vampire: dark skin tone # emoji-test.txt line #1750 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FF, 0x200D, 0x2642⟆ 🧛🏿‍♂ E5.0 man vampire: dark skin tone";
## 1F9DB 200D 2640 FE0F                       ; fully-qualified     # 🧛‍♀️ E5.0 woman vampire # emoji-test.txt line #1751 Emoji version 13.0
is Uni.new(0x1F9DB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x200D, 0x2640, 0xFE0F⟆ 🧛‍♀️ E5.0 woman vampire";
## 1F9DB 200D 2640                            ; minimally-qualified # 🧛‍♀ E5.0 woman vampire # emoji-test.txt line #1752 Emoji version 13.0
is Uni.new(0x1F9DB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x200D, 0x2640⟆ 🧛‍♀ E5.0 woman vampire";
## 1F9DB 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧛🏻‍♀️ E5.0 woman vampire: light skin tone # emoji-test.txt line #1753 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧛🏻‍♀️ E5.0 woman vampire: light skin tone";
## 1F9DB 1F3FB 200D 2640                      ; minimally-qualified # 🧛🏻‍♀ E5.0 woman vampire: light skin tone # emoji-test.txt line #1754 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FB, 0x200D, 0x2640⟆ 🧛🏻‍♀ E5.0 woman vampire: light skin tone";
## 1F9DB 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧛🏼‍♀️ E5.0 woman vampire: medium-light skin tone # emoji-test.txt line #1755 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧛🏼‍♀️ E5.0 woman vampire: medium-light skin tone";
## 1F9DB 1F3FC 200D 2640                      ; minimally-qualified # 🧛🏼‍♀ E5.0 woman vampire: medium-light skin tone # emoji-test.txt line #1756 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FC, 0x200D, 0x2640⟆ 🧛🏼‍♀ E5.0 woman vampire: medium-light skin tone";
## 1F9DB 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧛🏽‍♀️ E5.0 woman vampire: medium skin tone # emoji-test.txt line #1757 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧛🏽‍♀️ E5.0 woman vampire: medium skin tone";
## 1F9DB 1F3FD 200D 2640                      ; minimally-qualified # 🧛🏽‍♀ E5.0 woman vampire: medium skin tone # emoji-test.txt line #1758 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FD, 0x200D, 0x2640⟆ 🧛🏽‍♀ E5.0 woman vampire: medium skin tone";
## 1F9DB 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧛🏾‍♀️ E5.0 woman vampire: medium-dark skin tone # emoji-test.txt line #1759 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧛🏾‍♀️ E5.0 woman vampire: medium-dark skin tone";
## 1F9DB 1F3FE 200D 2640                      ; minimally-qualified # 🧛🏾‍♀ E5.0 woman vampire: medium-dark skin tone # emoji-test.txt line #1760 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FE, 0x200D, 0x2640⟆ 🧛🏾‍♀ E5.0 woman vampire: medium-dark skin tone";
## 1F9DB 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧛🏿‍♀️ E5.0 woman vampire: dark skin tone # emoji-test.txt line #1761 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧛🏿‍♀️ E5.0 woman vampire: dark skin tone";
## 1F9DB 1F3FF 200D 2640                      ; minimally-qualified # 🧛🏿‍♀ E5.0 woman vampire: dark skin tone # emoji-test.txt line #1762 Emoji version 13.0
is Uni.new(0x1F9DB, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DB, 0x1F3FF, 0x200D, 0x2640⟆ 🧛🏿‍♀ E5.0 woman vampire: dark skin tone";
## 1F9DC 1F3FB                                ; fully-qualified     # 🧜🏻 E5.0 merperson: light skin tone # emoji-test.txt line #1764 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FB⟆ 🧜🏻 E5.0 merperson: light skin tone";
## 1F9DC 1F3FC                                ; fully-qualified     # 🧜🏼 E5.0 merperson: medium-light skin tone # emoji-test.txt line #1765 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FC⟆ 🧜🏼 E5.0 merperson: medium-light skin tone";
## 1F9DC 1F3FD                                ; fully-qualified     # 🧜🏽 E5.0 merperson: medium skin tone # emoji-test.txt line #1766 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FD⟆ 🧜🏽 E5.0 merperson: medium skin tone";
## 1F9DC 1F3FE                                ; fully-qualified     # 🧜🏾 E5.0 merperson: medium-dark skin tone # emoji-test.txt line #1767 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FE⟆ 🧜🏾 E5.0 merperson: medium-dark skin tone";
## 1F9DC 1F3FF                                ; fully-qualified     # 🧜🏿 E5.0 merperson: dark skin tone # emoji-test.txt line #1768 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FF⟆ 🧜🏿 E5.0 merperson: dark skin tone";
## 1F9DC 200D 2642 FE0F                       ; fully-qualified     # 🧜‍♂️ E5.0 merman # emoji-test.txt line #1769 Emoji version 13.0
is Uni.new(0x1F9DC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x200D, 0x2642, 0xFE0F⟆ 🧜‍♂️ E5.0 merman";
## 1F9DC 200D 2642                            ; minimally-qualified # 🧜‍♂ E5.0 merman # emoji-test.txt line #1770 Emoji version 13.0
is Uni.new(0x1F9DC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x200D, 0x2642⟆ 🧜‍♂ E5.0 merman";
## 1F9DC 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧜🏻‍♂️ E5.0 merman: light skin tone # emoji-test.txt line #1771 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧜🏻‍♂️ E5.0 merman: light skin tone";
## 1F9DC 1F3FB 200D 2642                      ; minimally-qualified # 🧜🏻‍♂ E5.0 merman: light skin tone # emoji-test.txt line #1772 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FB, 0x200D, 0x2642⟆ 🧜🏻‍♂ E5.0 merman: light skin tone";
## 1F9DC 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧜🏼‍♂️ E5.0 merman: medium-light skin tone # emoji-test.txt line #1773 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧜🏼‍♂️ E5.0 merman: medium-light skin tone";
## 1F9DC 1F3FC 200D 2642                      ; minimally-qualified # 🧜🏼‍♂ E5.0 merman: medium-light skin tone # emoji-test.txt line #1774 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FC, 0x200D, 0x2642⟆ 🧜🏼‍♂ E5.0 merman: medium-light skin tone";
## 1F9DC 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧜🏽‍♂️ E5.0 merman: medium skin tone # emoji-test.txt line #1775 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧜🏽‍♂️ E5.0 merman: medium skin tone";
## 1F9DC 1F3FD 200D 2642                      ; minimally-qualified # 🧜🏽‍♂ E5.0 merman: medium skin tone # emoji-test.txt line #1776 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FD, 0x200D, 0x2642⟆ 🧜🏽‍♂ E5.0 merman: medium skin tone";
## 1F9DC 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧜🏾‍♂️ E5.0 merman: medium-dark skin tone # emoji-test.txt line #1777 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧜🏾‍♂️ E5.0 merman: medium-dark skin tone";
## 1F9DC 1F3FE 200D 2642                      ; minimally-qualified # 🧜🏾‍♂ E5.0 merman: medium-dark skin tone # emoji-test.txt line #1778 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FE, 0x200D, 0x2642⟆ 🧜🏾‍♂ E5.0 merman: medium-dark skin tone";
## 1F9DC 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧜🏿‍♂️ E5.0 merman: dark skin tone # emoji-test.txt line #1779 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧜🏿‍♂️ E5.0 merman: dark skin tone";
## 1F9DC 1F3FF 200D 2642                      ; minimally-qualified # 🧜🏿‍♂ E5.0 merman: dark skin tone # emoji-test.txt line #1780 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FF, 0x200D, 0x2642⟆ 🧜🏿‍♂ E5.0 merman: dark skin tone";
## 1F9DC 200D 2640 FE0F                       ; fully-qualified     # 🧜‍♀️ E5.0 mermaid # emoji-test.txt line #1781 Emoji version 13.0
is Uni.new(0x1F9DC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x200D, 0x2640, 0xFE0F⟆ 🧜‍♀️ E5.0 mermaid";
## 1F9DC 200D 2640                            ; minimally-qualified # 🧜‍♀ E5.0 mermaid # emoji-test.txt line #1782 Emoji version 13.0
is Uni.new(0x1F9DC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x200D, 0x2640⟆ 🧜‍♀ E5.0 mermaid";
## 1F9DC 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧜🏻‍♀️ E5.0 mermaid: light skin tone # emoji-test.txt line #1783 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧜🏻‍♀️ E5.0 mermaid: light skin tone";
## 1F9DC 1F3FB 200D 2640                      ; minimally-qualified # 🧜🏻‍♀ E5.0 mermaid: light skin tone # emoji-test.txt line #1784 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FB, 0x200D, 0x2640⟆ 🧜🏻‍♀ E5.0 mermaid: light skin tone";
## 1F9DC 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧜🏼‍♀️ E5.0 mermaid: medium-light skin tone # emoji-test.txt line #1785 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧜🏼‍♀️ E5.0 mermaid: medium-light skin tone";
## 1F9DC 1F3FC 200D 2640                      ; minimally-qualified # 🧜🏼‍♀ E5.0 mermaid: medium-light skin tone # emoji-test.txt line #1786 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FC, 0x200D, 0x2640⟆ 🧜🏼‍♀ E5.0 mermaid: medium-light skin tone";
## 1F9DC 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧜🏽‍♀️ E5.0 mermaid: medium skin tone # emoji-test.txt line #1787 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧜🏽‍♀️ E5.0 mermaid: medium skin tone";
## 1F9DC 1F3FD 200D 2640                      ; minimally-qualified # 🧜🏽‍♀ E5.0 mermaid: medium skin tone # emoji-test.txt line #1788 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FD, 0x200D, 0x2640⟆ 🧜🏽‍♀ E5.0 mermaid: medium skin tone";
## 1F9DC 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧜🏾‍♀️ E5.0 mermaid: medium-dark skin tone # emoji-test.txt line #1789 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧜🏾‍♀️ E5.0 mermaid: medium-dark skin tone";
## 1F9DC 1F3FE 200D 2640                      ; minimally-qualified # 🧜🏾‍♀ E5.0 mermaid: medium-dark skin tone # emoji-test.txt line #1790 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FE, 0x200D, 0x2640⟆ 🧜🏾‍♀ E5.0 mermaid: medium-dark skin tone";
## 1F9DC 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧜🏿‍♀️ E5.0 mermaid: dark skin tone # emoji-test.txt line #1791 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧜🏿‍♀️ E5.0 mermaid: dark skin tone";
## 1F9DC 1F3FF 200D 2640                      ; minimally-qualified # 🧜🏿‍♀ E5.0 mermaid: dark skin tone # emoji-test.txt line #1792 Emoji version 13.0
is Uni.new(0x1F9DC, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DC, 0x1F3FF, 0x200D, 0x2640⟆ 🧜🏿‍♀ E5.0 mermaid: dark skin tone";
## 1F9DD 1F3FB                                ; fully-qualified     # 🧝🏻 E5.0 elf: light skin tone # emoji-test.txt line #1794 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FB⟆ 🧝🏻 E5.0 elf: light skin tone";
## 1F9DD 1F3FC                                ; fully-qualified     # 🧝🏼 E5.0 elf: medium-light skin tone # emoji-test.txt line #1795 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FC⟆ 🧝🏼 E5.0 elf: medium-light skin tone";
## 1F9DD 1F3FD                                ; fully-qualified     # 🧝🏽 E5.0 elf: medium skin tone # emoji-test.txt line #1796 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FD⟆ 🧝🏽 E5.0 elf: medium skin tone";
## 1F9DD 1F3FE                                ; fully-qualified     # 🧝🏾 E5.0 elf: medium-dark skin tone # emoji-test.txt line #1797 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FE⟆ 🧝🏾 E5.0 elf: medium-dark skin tone";
## 1F9DD 1F3FF                                ; fully-qualified     # 🧝🏿 E5.0 elf: dark skin tone # emoji-test.txt line #1798 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FF⟆ 🧝🏿 E5.0 elf: dark skin tone";
## 1F9DD 200D 2642 FE0F                       ; fully-qualified     # 🧝‍♂️ E5.0 man elf # emoji-test.txt line #1799 Emoji version 13.0
is Uni.new(0x1F9DD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x200D, 0x2642, 0xFE0F⟆ 🧝‍♂️ E5.0 man elf";
## 1F9DD 200D 2642                            ; minimally-qualified # 🧝‍♂ E5.0 man elf # emoji-test.txt line #1800 Emoji version 13.0
is Uni.new(0x1F9DD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x200D, 0x2642⟆ 🧝‍♂ E5.0 man elf";
## 1F9DD 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧝🏻‍♂️ E5.0 man elf: light skin tone # emoji-test.txt line #1801 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧝🏻‍♂️ E5.0 man elf: light skin tone";
## 1F9DD 1F3FB 200D 2642                      ; minimally-qualified # 🧝🏻‍♂ E5.0 man elf: light skin tone # emoji-test.txt line #1802 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FB, 0x200D, 0x2642⟆ 🧝🏻‍♂ E5.0 man elf: light skin tone";
## 1F9DD 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧝🏼‍♂️ E5.0 man elf: medium-light skin tone # emoji-test.txt line #1803 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧝🏼‍♂️ E5.0 man elf: medium-light skin tone";
## 1F9DD 1F3FC 200D 2642                      ; minimally-qualified # 🧝🏼‍♂ E5.0 man elf: medium-light skin tone # emoji-test.txt line #1804 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FC, 0x200D, 0x2642⟆ 🧝🏼‍♂ E5.0 man elf: medium-light skin tone";
## 1F9DD 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧝🏽‍♂️ E5.0 man elf: medium skin tone # emoji-test.txt line #1805 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧝🏽‍♂️ E5.0 man elf: medium skin tone";
## 1F9DD 1F3FD 200D 2642                      ; minimally-qualified # 🧝🏽‍♂ E5.0 man elf: medium skin tone # emoji-test.txt line #1806 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FD, 0x200D, 0x2642⟆ 🧝🏽‍♂ E5.0 man elf: medium skin tone";
## 1F9DD 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧝🏾‍♂️ E5.0 man elf: medium-dark skin tone # emoji-test.txt line #1807 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧝🏾‍♂️ E5.0 man elf: medium-dark skin tone";
## 1F9DD 1F3FE 200D 2642                      ; minimally-qualified # 🧝🏾‍♂ E5.0 man elf: medium-dark skin tone # emoji-test.txt line #1808 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FE, 0x200D, 0x2642⟆ 🧝🏾‍♂ E5.0 man elf: medium-dark skin tone";
## 1F9DD 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧝🏿‍♂️ E5.0 man elf: dark skin tone # emoji-test.txt line #1809 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧝🏿‍♂️ E5.0 man elf: dark skin tone";
## 1F9DD 1F3FF 200D 2642                      ; minimally-qualified # 🧝🏿‍♂ E5.0 man elf: dark skin tone # emoji-test.txt line #1810 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FF, 0x200D, 0x2642⟆ 🧝🏿‍♂ E5.0 man elf: dark skin tone";
## 1F9DD 200D 2640 FE0F                       ; fully-qualified     # 🧝‍♀️ E5.0 woman elf # emoji-test.txt line #1811 Emoji version 13.0
is Uni.new(0x1F9DD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x200D, 0x2640, 0xFE0F⟆ 🧝‍♀️ E5.0 woman elf";
## 1F9DD 200D 2640                            ; minimally-qualified # 🧝‍♀ E5.0 woman elf # emoji-test.txt line #1812 Emoji version 13.0
is Uni.new(0x1F9DD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x200D, 0x2640⟆ 🧝‍♀ E5.0 woman elf";
## 1F9DD 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧝🏻‍♀️ E5.0 woman elf: light skin tone # emoji-test.txt line #1813 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧝🏻‍♀️ E5.0 woman elf: light skin tone";
## 1F9DD 1F3FB 200D 2640                      ; minimally-qualified # 🧝🏻‍♀ E5.0 woman elf: light skin tone # emoji-test.txt line #1814 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FB, 0x200D, 0x2640⟆ 🧝🏻‍♀ E5.0 woman elf: light skin tone";
## 1F9DD 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧝🏼‍♀️ E5.0 woman elf: medium-light skin tone # emoji-test.txt line #1815 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧝🏼‍♀️ E5.0 woman elf: medium-light skin tone";
## 1F9DD 1F3FC 200D 2640                      ; minimally-qualified # 🧝🏼‍♀ E5.0 woman elf: medium-light skin tone # emoji-test.txt line #1816 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FC, 0x200D, 0x2640⟆ 🧝🏼‍♀ E5.0 woman elf: medium-light skin tone";
## 1F9DD 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧝🏽‍♀️ E5.0 woman elf: medium skin tone # emoji-test.txt line #1817 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧝🏽‍♀️ E5.0 woman elf: medium skin tone";
## 1F9DD 1F3FD 200D 2640                      ; minimally-qualified # 🧝🏽‍♀ E5.0 woman elf: medium skin tone # emoji-test.txt line #1818 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FD, 0x200D, 0x2640⟆ 🧝🏽‍♀ E5.0 woman elf: medium skin tone";
## 1F9DD 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧝🏾‍♀️ E5.0 woman elf: medium-dark skin tone # emoji-test.txt line #1819 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧝🏾‍♀️ E5.0 woman elf: medium-dark skin tone";
## 1F9DD 1F3FE 200D 2640                      ; minimally-qualified # 🧝🏾‍♀ E5.0 woman elf: medium-dark skin tone # emoji-test.txt line #1820 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FE, 0x200D, 0x2640⟆ 🧝🏾‍♀ E5.0 woman elf: medium-dark skin tone";
## 1F9DD 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧝🏿‍♀️ E5.0 woman elf: dark skin tone # emoji-test.txt line #1821 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧝🏿‍♀️ E5.0 woman elf: dark skin tone";
## 1F9DD 1F3FF 200D 2640                      ; minimally-qualified # 🧝🏿‍♀ E5.0 woman elf: dark skin tone # emoji-test.txt line #1822 Emoji version 13.0
is Uni.new(0x1F9DD, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DD, 0x1F3FF, 0x200D, 0x2640⟆ 🧝🏿‍♀ E5.0 woman elf: dark skin tone";
## 1F9DE 200D 2642 FE0F                       ; fully-qualified     # 🧞‍♂️ E5.0 man genie # emoji-test.txt line #1824 Emoji version 13.0
is Uni.new(0x1F9DE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DE, 0x200D, 0x2642, 0xFE0F⟆ 🧞‍♂️ E5.0 man genie";
## 1F9DE 200D 2642                            ; minimally-qualified # 🧞‍♂ E5.0 man genie # emoji-test.txt line #1825 Emoji version 13.0
is Uni.new(0x1F9DE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DE, 0x200D, 0x2642⟆ 🧞‍♂ E5.0 man genie";
## 1F9DE 200D 2640 FE0F                       ; fully-qualified     # 🧞‍♀️ E5.0 woman genie # emoji-test.txt line #1826 Emoji version 13.0
is Uni.new(0x1F9DE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DE, 0x200D, 0x2640, 0xFE0F⟆ 🧞‍♀️ E5.0 woman genie";
## 1F9DE 200D 2640                            ; minimally-qualified # 🧞‍♀ E5.0 woman genie # emoji-test.txt line #1827 Emoji version 13.0
is Uni.new(0x1F9DE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DE, 0x200D, 0x2640⟆ 🧞‍♀ E5.0 woman genie";
## 1F9DF 200D 2642 FE0F                       ; fully-qualified     # 🧟‍♂️ E5.0 man zombie # emoji-test.txt line #1829 Emoji version 13.0
is Uni.new(0x1F9DF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DF, 0x200D, 0x2642, 0xFE0F⟆ 🧟‍♂️ E5.0 man zombie";
## 1F9DF 200D 2642                            ; minimally-qualified # 🧟‍♂ E5.0 man zombie # emoji-test.txt line #1830 Emoji version 13.0
is Uni.new(0x1F9DF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9DF, 0x200D, 0x2642⟆ 🧟‍♂ E5.0 man zombie";
## 1F9DF 200D 2640 FE0F                       ; fully-qualified     # 🧟‍♀️ E5.0 woman zombie # emoji-test.txt line #1831 Emoji version 13.0
is Uni.new(0x1F9DF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9DF, 0x200D, 0x2640, 0xFE0F⟆ 🧟‍♀️ E5.0 woman zombie";
## 1F9DF 200D 2640                            ; minimally-qualified # 🧟‍♀ E5.0 woman zombie # emoji-test.txt line #1832 Emoji version 13.0
is Uni.new(0x1F9DF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9DF, 0x200D, 0x2640⟆ 🧟‍♀ E5.0 woman zombie";
## 1F486 1F3FB                                ; fully-qualified     # 💆🏻 E1.0 person getting massage: light skin tone # emoji-test.txt line #1836 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FB⟆ 💆🏻 E1.0 person getting massage: light skin tone";
## 1F486 1F3FC                                ; fully-qualified     # 💆🏼 E1.0 person getting massage: medium-light skin tone # emoji-test.txt line #1837 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FC⟆ 💆🏼 E1.0 person getting massage: medium-light skin tone";
## 1F486 1F3FD                                ; fully-qualified     # 💆🏽 E1.0 person getting massage: medium skin tone # emoji-test.txt line #1838 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FD⟆ 💆🏽 E1.0 person getting massage: medium skin tone";
## 1F486 1F3FE                                ; fully-qualified     # 💆🏾 E1.0 person getting massage: medium-dark skin tone # emoji-test.txt line #1839 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FE⟆ 💆🏾 E1.0 person getting massage: medium-dark skin tone";
## 1F486 1F3FF                                ; fully-qualified     # 💆🏿 E1.0 person getting massage: dark skin tone # emoji-test.txt line #1840 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FF⟆ 💆🏿 E1.0 person getting massage: dark skin tone";
## 1F486 200D 2642 FE0F                       ; fully-qualified     # 💆‍♂️ E4.0 man getting massage # emoji-test.txt line #1841 Emoji version 13.0
is Uni.new(0x1F486, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x200D, 0x2642, 0xFE0F⟆ 💆‍♂️ E4.0 man getting massage";
## 1F486 200D 2642                            ; minimally-qualified # 💆‍♂ E4.0 man getting massage # emoji-test.txt line #1842 Emoji version 13.0
is Uni.new(0x1F486, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F486, 0x200D, 0x2642⟆ 💆‍♂ E4.0 man getting massage";
## 1F486 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 💆🏻‍♂️ E4.0 man getting massage: light skin tone # emoji-test.txt line #1843 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 💆🏻‍♂️ E4.0 man getting massage: light skin tone";
## 1F486 1F3FB 200D 2642                      ; minimally-qualified # 💆🏻‍♂ E4.0 man getting massage: light skin tone # emoji-test.txt line #1844 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FB, 0x200D, 0x2642⟆ 💆🏻‍♂ E4.0 man getting massage: light skin tone";
## 1F486 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 💆🏼‍♂️ E4.0 man getting massage: medium-light skin tone # emoji-test.txt line #1845 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 💆🏼‍♂️ E4.0 man getting massage: medium-light skin tone";
## 1F486 1F3FC 200D 2642                      ; minimally-qualified # 💆🏼‍♂ E4.0 man getting massage: medium-light skin tone # emoji-test.txt line #1846 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FC, 0x200D, 0x2642⟆ 💆🏼‍♂ E4.0 man getting massage: medium-light skin tone";
## 1F486 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 💆🏽‍♂️ E4.0 man getting massage: medium skin tone # emoji-test.txt line #1847 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 💆🏽‍♂️ E4.0 man getting massage: medium skin tone";
## 1F486 1F3FD 200D 2642                      ; minimally-qualified # 💆🏽‍♂ E4.0 man getting massage: medium skin tone # emoji-test.txt line #1848 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FD, 0x200D, 0x2642⟆ 💆🏽‍♂ E4.0 man getting massage: medium skin tone";
## 1F486 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 💆🏾‍♂️ E4.0 man getting massage: medium-dark skin tone # emoji-test.txt line #1849 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 💆🏾‍♂️ E4.0 man getting massage: medium-dark skin tone";
## 1F486 1F3FE 200D 2642                      ; minimally-qualified # 💆🏾‍♂ E4.0 man getting massage: medium-dark skin tone # emoji-test.txt line #1850 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FE, 0x200D, 0x2642⟆ 💆🏾‍♂ E4.0 man getting massage: medium-dark skin tone";
## 1F486 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 💆🏿‍♂️ E4.0 man getting massage: dark skin tone # emoji-test.txt line #1851 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 💆🏿‍♂️ E4.0 man getting massage: dark skin tone";
## 1F486 1F3FF 200D 2642                      ; minimally-qualified # 💆🏿‍♂ E4.0 man getting massage: dark skin tone # emoji-test.txt line #1852 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FF, 0x200D, 0x2642⟆ 💆🏿‍♂ E4.0 man getting massage: dark skin tone";
## 1F486 200D 2640 FE0F                       ; fully-qualified     # 💆‍♀️ E4.0 woman getting massage # emoji-test.txt line #1853 Emoji version 13.0
is Uni.new(0x1F486, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x200D, 0x2640, 0xFE0F⟆ 💆‍♀️ E4.0 woman getting massage";
## 1F486 200D 2640                            ; minimally-qualified # 💆‍♀ E4.0 woman getting massage # emoji-test.txt line #1854 Emoji version 13.0
is Uni.new(0x1F486, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F486, 0x200D, 0x2640⟆ 💆‍♀ E4.0 woman getting massage";
## 1F486 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 💆🏻‍♀️ E4.0 woman getting massage: light skin tone # emoji-test.txt line #1855 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 💆🏻‍♀️ E4.0 woman getting massage: light skin tone";
## 1F486 1F3FB 200D 2640                      ; minimally-qualified # 💆🏻‍♀ E4.0 woman getting massage: light skin tone # emoji-test.txt line #1856 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FB, 0x200D, 0x2640⟆ 💆🏻‍♀ E4.0 woman getting massage: light skin tone";
## 1F486 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 💆🏼‍♀️ E4.0 woman getting massage: medium-light skin tone # emoji-test.txt line #1857 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 💆🏼‍♀️ E4.0 woman getting massage: medium-light skin tone";
## 1F486 1F3FC 200D 2640                      ; minimally-qualified # 💆🏼‍♀ E4.0 woman getting massage: medium-light skin tone # emoji-test.txt line #1858 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FC, 0x200D, 0x2640⟆ 💆🏼‍♀ E4.0 woman getting massage: medium-light skin tone";
## 1F486 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 💆🏽‍♀️ E4.0 woman getting massage: medium skin tone # emoji-test.txt line #1859 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 💆🏽‍♀️ E4.0 woman getting massage: medium skin tone";
## 1F486 1F3FD 200D 2640                      ; minimally-qualified # 💆🏽‍♀ E4.0 woman getting massage: medium skin tone # emoji-test.txt line #1860 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FD, 0x200D, 0x2640⟆ 💆🏽‍♀ E4.0 woman getting massage: medium skin tone";
## 1F486 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 💆🏾‍♀️ E4.0 woman getting massage: medium-dark skin tone # emoji-test.txt line #1861 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 💆🏾‍♀️ E4.0 woman getting massage: medium-dark skin tone";
## 1F486 1F3FE 200D 2640                      ; minimally-qualified # 💆🏾‍♀ E4.0 woman getting massage: medium-dark skin tone # emoji-test.txt line #1862 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FE, 0x200D, 0x2640⟆ 💆🏾‍♀ E4.0 woman getting massage: medium-dark skin tone";
## 1F486 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 💆🏿‍♀️ E4.0 woman getting massage: dark skin tone # emoji-test.txt line #1863 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 💆🏿‍♀️ E4.0 woman getting massage: dark skin tone";
## 1F486 1F3FF 200D 2640                      ; minimally-qualified # 💆🏿‍♀ E4.0 woman getting massage: dark skin tone # emoji-test.txt line #1864 Emoji version 13.0
is Uni.new(0x1F486, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F486, 0x1F3FF, 0x200D, 0x2640⟆ 💆🏿‍♀ E4.0 woman getting massage: dark skin tone";
## 1F487 1F3FB                                ; fully-qualified     # 💇🏻 E1.0 person getting haircut: light skin tone # emoji-test.txt line #1866 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FB⟆ 💇🏻 E1.0 person getting haircut: light skin tone";
## 1F487 1F3FC                                ; fully-qualified     # 💇🏼 E1.0 person getting haircut: medium-light skin tone # emoji-test.txt line #1867 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FC⟆ 💇🏼 E1.0 person getting haircut: medium-light skin tone";
## 1F487 1F3FD                                ; fully-qualified     # 💇🏽 E1.0 person getting haircut: medium skin tone # emoji-test.txt line #1868 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FD⟆ 💇🏽 E1.0 person getting haircut: medium skin tone";
## 1F487 1F3FE                                ; fully-qualified     # 💇🏾 E1.0 person getting haircut: medium-dark skin tone # emoji-test.txt line #1869 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FE⟆ 💇🏾 E1.0 person getting haircut: medium-dark skin tone";
## 1F487 1F3FF                                ; fully-qualified     # 💇🏿 E1.0 person getting haircut: dark skin tone # emoji-test.txt line #1870 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FF⟆ 💇🏿 E1.0 person getting haircut: dark skin tone";
## 1F487 200D 2642 FE0F                       ; fully-qualified     # 💇‍♂️ E4.0 man getting haircut # emoji-test.txt line #1871 Emoji version 13.0
is Uni.new(0x1F487, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x200D, 0x2642, 0xFE0F⟆ 💇‍♂️ E4.0 man getting haircut";
## 1F487 200D 2642                            ; minimally-qualified # 💇‍♂ E4.0 man getting haircut # emoji-test.txt line #1872 Emoji version 13.0
is Uni.new(0x1F487, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F487, 0x200D, 0x2642⟆ 💇‍♂ E4.0 man getting haircut";
## 1F487 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 💇🏻‍♂️ E4.0 man getting haircut: light skin tone # emoji-test.txt line #1873 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 💇🏻‍♂️ E4.0 man getting haircut: light skin tone";
## 1F487 1F3FB 200D 2642                      ; minimally-qualified # 💇🏻‍♂ E4.0 man getting haircut: light skin tone # emoji-test.txt line #1874 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FB, 0x200D, 0x2642⟆ 💇🏻‍♂ E4.0 man getting haircut: light skin tone";
## 1F487 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 💇🏼‍♂️ E4.0 man getting haircut: medium-light skin tone # emoji-test.txt line #1875 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 💇🏼‍♂️ E4.0 man getting haircut: medium-light skin tone";
## 1F487 1F3FC 200D 2642                      ; minimally-qualified # 💇🏼‍♂ E4.0 man getting haircut: medium-light skin tone # emoji-test.txt line #1876 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FC, 0x200D, 0x2642⟆ 💇🏼‍♂ E4.0 man getting haircut: medium-light skin tone";
## 1F487 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 💇🏽‍♂️ E4.0 man getting haircut: medium skin tone # emoji-test.txt line #1877 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 💇🏽‍♂️ E4.0 man getting haircut: medium skin tone";
## 1F487 1F3FD 200D 2642                      ; minimally-qualified # 💇🏽‍♂ E4.0 man getting haircut: medium skin tone # emoji-test.txt line #1878 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FD, 0x200D, 0x2642⟆ 💇🏽‍♂ E4.0 man getting haircut: medium skin tone";
## 1F487 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 💇🏾‍♂️ E4.0 man getting haircut: medium-dark skin tone # emoji-test.txt line #1879 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 💇🏾‍♂️ E4.0 man getting haircut: medium-dark skin tone";
## 1F487 1F3FE 200D 2642                      ; minimally-qualified # 💇🏾‍♂ E4.0 man getting haircut: medium-dark skin tone # emoji-test.txt line #1880 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FE, 0x200D, 0x2642⟆ 💇🏾‍♂ E4.0 man getting haircut: medium-dark skin tone";
## 1F487 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 💇🏿‍♂️ E4.0 man getting haircut: dark skin tone # emoji-test.txt line #1881 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 💇🏿‍♂️ E4.0 man getting haircut: dark skin tone";
## 1F487 1F3FF 200D 2642                      ; minimally-qualified # 💇🏿‍♂ E4.0 man getting haircut: dark skin tone # emoji-test.txt line #1882 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FF, 0x200D, 0x2642⟆ 💇🏿‍♂ E4.0 man getting haircut: dark skin tone";
## 1F487 200D 2640 FE0F                       ; fully-qualified     # 💇‍♀️ E4.0 woman getting haircut # emoji-test.txt line #1883 Emoji version 13.0
is Uni.new(0x1F487, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x200D, 0x2640, 0xFE0F⟆ 💇‍♀️ E4.0 woman getting haircut";
## 1F487 200D 2640                            ; minimally-qualified # 💇‍♀ E4.0 woman getting haircut # emoji-test.txt line #1884 Emoji version 13.0
is Uni.new(0x1F487, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F487, 0x200D, 0x2640⟆ 💇‍♀ E4.0 woman getting haircut";
## 1F487 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 💇🏻‍♀️ E4.0 woman getting haircut: light skin tone # emoji-test.txt line #1885 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 💇🏻‍♀️ E4.0 woman getting haircut: light skin tone";
## 1F487 1F3FB 200D 2640                      ; minimally-qualified # 💇🏻‍♀ E4.0 woman getting haircut: light skin tone # emoji-test.txt line #1886 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FB, 0x200D, 0x2640⟆ 💇🏻‍♀ E4.0 woman getting haircut: light skin tone";
## 1F487 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 💇🏼‍♀️ E4.0 woman getting haircut: medium-light skin tone # emoji-test.txt line #1887 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 💇🏼‍♀️ E4.0 woman getting haircut: medium-light skin tone";
## 1F487 1F3FC 200D 2640                      ; minimally-qualified # 💇🏼‍♀ E4.0 woman getting haircut: medium-light skin tone # emoji-test.txt line #1888 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FC, 0x200D, 0x2640⟆ 💇🏼‍♀ E4.0 woman getting haircut: medium-light skin tone";
## 1F487 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 💇🏽‍♀️ E4.0 woman getting haircut: medium skin tone # emoji-test.txt line #1889 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 💇🏽‍♀️ E4.0 woman getting haircut: medium skin tone";
## 1F487 1F3FD 200D 2640                      ; minimally-qualified # 💇🏽‍♀ E4.0 woman getting haircut: medium skin tone # emoji-test.txt line #1890 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FD, 0x200D, 0x2640⟆ 💇🏽‍♀ E4.0 woman getting haircut: medium skin tone";
## 1F487 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 💇🏾‍♀️ E4.0 woman getting haircut: medium-dark skin tone # emoji-test.txt line #1891 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 💇🏾‍♀️ E4.0 woman getting haircut: medium-dark skin tone";
## 1F487 1F3FE 200D 2640                      ; minimally-qualified # 💇🏾‍♀ E4.0 woman getting haircut: medium-dark skin tone # emoji-test.txt line #1892 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FE, 0x200D, 0x2640⟆ 💇🏾‍♀ E4.0 woman getting haircut: medium-dark skin tone";
## 1F487 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 💇🏿‍♀️ E4.0 woman getting haircut: dark skin tone # emoji-test.txt line #1893 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 💇🏿‍♀️ E4.0 woman getting haircut: dark skin tone";
## 1F487 1F3FF 200D 2640                      ; minimally-qualified # 💇🏿‍♀ E4.0 woman getting haircut: dark skin tone # emoji-test.txt line #1894 Emoji version 13.0
is Uni.new(0x1F487, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F487, 0x1F3FF, 0x200D, 0x2640⟆ 💇🏿‍♀ E4.0 woman getting haircut: dark skin tone";
## 1F6B6 1F3FB                                ; fully-qualified     # 🚶🏻 E1.0 person walking: light skin tone # emoji-test.txt line #1896 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FB⟆ 🚶🏻 E1.0 person walking: light skin tone";
## 1F6B6 1F3FC                                ; fully-qualified     # 🚶🏼 E1.0 person walking: medium-light skin tone # emoji-test.txt line #1897 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FC⟆ 🚶🏼 E1.0 person walking: medium-light skin tone";
## 1F6B6 1F3FD                                ; fully-qualified     # 🚶🏽 E1.0 person walking: medium skin tone # emoji-test.txt line #1898 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FD⟆ 🚶🏽 E1.0 person walking: medium skin tone";
## 1F6B6 1F3FE                                ; fully-qualified     # 🚶🏾 E1.0 person walking: medium-dark skin tone # emoji-test.txt line #1899 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FE⟆ 🚶🏾 E1.0 person walking: medium-dark skin tone";
## 1F6B6 1F3FF                                ; fully-qualified     # 🚶🏿 E1.0 person walking: dark skin tone # emoji-test.txt line #1900 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FF⟆ 🚶🏿 E1.0 person walking: dark skin tone";
## 1F6B6 200D 2642 FE0F                       ; fully-qualified     # 🚶‍♂️ E4.0 man walking # emoji-test.txt line #1901 Emoji version 13.0
is Uni.new(0x1F6B6, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x200D, 0x2642, 0xFE0F⟆ 🚶‍♂️ E4.0 man walking";
## 1F6B6 200D 2642                            ; minimally-qualified # 🚶‍♂ E4.0 man walking # emoji-test.txt line #1902 Emoji version 13.0
is Uni.new(0x1F6B6, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x200D, 0x2642⟆ 🚶‍♂ E4.0 man walking";
## 1F6B6 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🚶🏻‍♂️ E4.0 man walking: light skin tone # emoji-test.txt line #1903 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🚶🏻‍♂️ E4.0 man walking: light skin tone";
## 1F6B6 1F3FB 200D 2642                      ; minimally-qualified # 🚶🏻‍♂ E4.0 man walking: light skin tone # emoji-test.txt line #1904 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FB, 0x200D, 0x2642⟆ 🚶🏻‍♂ E4.0 man walking: light skin tone";
## 1F6B6 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🚶🏼‍♂️ E4.0 man walking: medium-light skin tone # emoji-test.txt line #1905 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🚶🏼‍♂️ E4.0 man walking: medium-light skin tone";
## 1F6B6 1F3FC 200D 2642                      ; minimally-qualified # 🚶🏼‍♂ E4.0 man walking: medium-light skin tone # emoji-test.txt line #1906 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FC, 0x200D, 0x2642⟆ 🚶🏼‍♂ E4.0 man walking: medium-light skin tone";
## 1F6B6 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🚶🏽‍♂️ E4.0 man walking: medium skin tone # emoji-test.txt line #1907 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🚶🏽‍♂️ E4.0 man walking: medium skin tone";
## 1F6B6 1F3FD 200D 2642                      ; minimally-qualified # 🚶🏽‍♂ E4.0 man walking: medium skin tone # emoji-test.txt line #1908 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FD, 0x200D, 0x2642⟆ 🚶🏽‍♂ E4.0 man walking: medium skin tone";
## 1F6B6 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🚶🏾‍♂️ E4.0 man walking: medium-dark skin tone # emoji-test.txt line #1909 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🚶🏾‍♂️ E4.0 man walking: medium-dark skin tone";
## 1F6B6 1F3FE 200D 2642                      ; minimally-qualified # 🚶🏾‍♂ E4.0 man walking: medium-dark skin tone # emoji-test.txt line #1910 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FE, 0x200D, 0x2642⟆ 🚶🏾‍♂ E4.0 man walking: medium-dark skin tone";
## 1F6B6 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🚶🏿‍♂️ E4.0 man walking: dark skin tone # emoji-test.txt line #1911 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🚶🏿‍♂️ E4.0 man walking: dark skin tone";
## 1F6B6 1F3FF 200D 2642                      ; minimally-qualified # 🚶🏿‍♂ E4.0 man walking: dark skin tone # emoji-test.txt line #1912 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FF, 0x200D, 0x2642⟆ 🚶🏿‍♂ E4.0 man walking: dark skin tone";
## 1F6B6 200D 2640 FE0F                       ; fully-qualified     # 🚶‍♀️ E4.0 woman walking # emoji-test.txt line #1913 Emoji version 13.0
is Uni.new(0x1F6B6, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x200D, 0x2640, 0xFE0F⟆ 🚶‍♀️ E4.0 woman walking";
## 1F6B6 200D 2640                            ; minimally-qualified # 🚶‍♀ E4.0 woman walking # emoji-test.txt line #1914 Emoji version 13.0
is Uni.new(0x1F6B6, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x200D, 0x2640⟆ 🚶‍♀ E4.0 woman walking";
## 1F6B6 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🚶🏻‍♀️ E4.0 woman walking: light skin tone # emoji-test.txt line #1915 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🚶🏻‍♀️ E4.0 woman walking: light skin tone";
## 1F6B6 1F3FB 200D 2640                      ; minimally-qualified # 🚶🏻‍♀ E4.0 woman walking: light skin tone # emoji-test.txt line #1916 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FB, 0x200D, 0x2640⟆ 🚶🏻‍♀ E4.0 woman walking: light skin tone";
## 1F6B6 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🚶🏼‍♀️ E4.0 woman walking: medium-light skin tone # emoji-test.txt line #1917 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🚶🏼‍♀️ E4.0 woman walking: medium-light skin tone";
## 1F6B6 1F3FC 200D 2640                      ; minimally-qualified # 🚶🏼‍♀ E4.0 woman walking: medium-light skin tone # emoji-test.txt line #1918 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FC, 0x200D, 0x2640⟆ 🚶🏼‍♀ E4.0 woman walking: medium-light skin tone";
## 1F6B6 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🚶🏽‍♀️ E4.0 woman walking: medium skin tone # emoji-test.txt line #1919 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🚶🏽‍♀️ E4.0 woman walking: medium skin tone";
## 1F6B6 1F3FD 200D 2640                      ; minimally-qualified # 🚶🏽‍♀ E4.0 woman walking: medium skin tone # emoji-test.txt line #1920 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FD, 0x200D, 0x2640⟆ 🚶🏽‍♀ E4.0 woman walking: medium skin tone";
## 1F6B6 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🚶🏾‍♀️ E4.0 woman walking: medium-dark skin tone # emoji-test.txt line #1921 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🚶🏾‍♀️ E4.0 woman walking: medium-dark skin tone";
## 1F6B6 1F3FE 200D 2640                      ; minimally-qualified # 🚶🏾‍♀ E4.0 woman walking: medium-dark skin tone # emoji-test.txt line #1922 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FE, 0x200D, 0x2640⟆ 🚶🏾‍♀ E4.0 woman walking: medium-dark skin tone";
## 1F6B6 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🚶🏿‍♀️ E4.0 woman walking: dark skin tone # emoji-test.txt line #1923 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🚶🏿‍♀️ E4.0 woman walking: dark skin tone";
## 1F6B6 1F3FF 200D 2640                      ; minimally-qualified # 🚶🏿‍♀ E4.0 woman walking: dark skin tone # emoji-test.txt line #1924 Emoji version 13.0
is Uni.new(0x1F6B6, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B6, 0x1F3FF, 0x200D, 0x2640⟆ 🚶🏿‍♀ E4.0 woman walking: dark skin tone";
## 1F9CD 1F3FB                                ; fully-qualified     # 🧍🏻 E12.0 person standing: light skin tone # emoji-test.txt line #1926 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FB⟆ 🧍🏻 E12.0 person standing: light skin tone";
## 1F9CD 1F3FC                                ; fully-qualified     # 🧍🏼 E12.0 person standing: medium-light skin tone # emoji-test.txt line #1927 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FC⟆ 🧍🏼 E12.0 person standing: medium-light skin tone";
## 1F9CD 1F3FD                                ; fully-qualified     # 🧍🏽 E12.0 person standing: medium skin tone # emoji-test.txt line #1928 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FD⟆ 🧍🏽 E12.0 person standing: medium skin tone";
## 1F9CD 1F3FE                                ; fully-qualified     # 🧍🏾 E12.0 person standing: medium-dark skin tone # emoji-test.txt line #1929 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FE⟆ 🧍🏾 E12.0 person standing: medium-dark skin tone";
## 1F9CD 1F3FF                                ; fully-qualified     # 🧍🏿 E12.0 person standing: dark skin tone # emoji-test.txt line #1930 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FF⟆ 🧍🏿 E12.0 person standing: dark skin tone";
## 1F9CD 200D 2642 FE0F                       ; fully-qualified     # 🧍‍♂️ E12.0 man standing # emoji-test.txt line #1931 Emoji version 13.0
is Uni.new(0x1F9CD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x200D, 0x2642, 0xFE0F⟆ 🧍‍♂️ E12.0 man standing";
## 1F9CD 200D 2642                            ; minimally-qualified # 🧍‍♂ E12.0 man standing # emoji-test.txt line #1932 Emoji version 13.0
is Uni.new(0x1F9CD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x200D, 0x2642⟆ 🧍‍♂ E12.0 man standing";
## 1F9CD 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧍🏻‍♂️ E12.0 man standing: light skin tone # emoji-test.txt line #1933 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧍🏻‍♂️ E12.0 man standing: light skin tone";
## 1F9CD 1F3FB 200D 2642                      ; minimally-qualified # 🧍🏻‍♂ E12.0 man standing: light skin tone # emoji-test.txt line #1934 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FB, 0x200D, 0x2642⟆ 🧍🏻‍♂ E12.0 man standing: light skin tone";
## 1F9CD 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧍🏼‍♂️ E12.0 man standing: medium-light skin tone # emoji-test.txt line #1935 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧍🏼‍♂️ E12.0 man standing: medium-light skin tone";
## 1F9CD 1F3FC 200D 2642                      ; minimally-qualified # 🧍🏼‍♂ E12.0 man standing: medium-light skin tone # emoji-test.txt line #1936 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FC, 0x200D, 0x2642⟆ 🧍🏼‍♂ E12.0 man standing: medium-light skin tone";
## 1F9CD 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧍🏽‍♂️ E12.0 man standing: medium skin tone # emoji-test.txt line #1937 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧍🏽‍♂️ E12.0 man standing: medium skin tone";
## 1F9CD 1F3FD 200D 2642                      ; minimally-qualified # 🧍🏽‍♂ E12.0 man standing: medium skin tone # emoji-test.txt line #1938 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FD, 0x200D, 0x2642⟆ 🧍🏽‍♂ E12.0 man standing: medium skin tone";
## 1F9CD 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧍🏾‍♂️ E12.0 man standing: medium-dark skin tone # emoji-test.txt line #1939 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧍🏾‍♂️ E12.0 man standing: medium-dark skin tone";
## 1F9CD 1F3FE 200D 2642                      ; minimally-qualified # 🧍🏾‍♂ E12.0 man standing: medium-dark skin tone # emoji-test.txt line #1940 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FE, 0x200D, 0x2642⟆ 🧍🏾‍♂ E12.0 man standing: medium-dark skin tone";
## 1F9CD 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧍🏿‍♂️ E12.0 man standing: dark skin tone # emoji-test.txt line #1941 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧍🏿‍♂️ E12.0 man standing: dark skin tone";
## 1F9CD 1F3FF 200D 2642                      ; minimally-qualified # 🧍🏿‍♂ E12.0 man standing: dark skin tone # emoji-test.txt line #1942 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FF, 0x200D, 0x2642⟆ 🧍🏿‍♂ E12.0 man standing: dark skin tone";
## 1F9CD 200D 2640 FE0F                       ; fully-qualified     # 🧍‍♀️ E12.0 woman standing # emoji-test.txt line #1943 Emoji version 13.0
is Uni.new(0x1F9CD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x200D, 0x2640, 0xFE0F⟆ 🧍‍♀️ E12.0 woman standing";
## 1F9CD 200D 2640                            ; minimally-qualified # 🧍‍♀ E12.0 woman standing # emoji-test.txt line #1944 Emoji version 13.0
is Uni.new(0x1F9CD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x200D, 0x2640⟆ 🧍‍♀ E12.0 woman standing";
## 1F9CD 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧍🏻‍♀️ E12.0 woman standing: light skin tone # emoji-test.txt line #1945 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧍🏻‍♀️ E12.0 woman standing: light skin tone";
## 1F9CD 1F3FB 200D 2640                      ; minimally-qualified # 🧍🏻‍♀ E12.0 woman standing: light skin tone # emoji-test.txt line #1946 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FB, 0x200D, 0x2640⟆ 🧍🏻‍♀ E12.0 woman standing: light skin tone";
## 1F9CD 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧍🏼‍♀️ E12.0 woman standing: medium-light skin tone # emoji-test.txt line #1947 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧍🏼‍♀️ E12.0 woman standing: medium-light skin tone";
## 1F9CD 1F3FC 200D 2640                      ; minimally-qualified # 🧍🏼‍♀ E12.0 woman standing: medium-light skin tone # emoji-test.txt line #1948 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FC, 0x200D, 0x2640⟆ 🧍🏼‍♀ E12.0 woman standing: medium-light skin tone";
## 1F9CD 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧍🏽‍♀️ E12.0 woman standing: medium skin tone # emoji-test.txt line #1949 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧍🏽‍♀️ E12.0 woman standing: medium skin tone";
## 1F9CD 1F3FD 200D 2640                      ; minimally-qualified # 🧍🏽‍♀ E12.0 woman standing: medium skin tone # emoji-test.txt line #1950 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FD, 0x200D, 0x2640⟆ 🧍🏽‍♀ E12.0 woman standing: medium skin tone";
## 1F9CD 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧍🏾‍♀️ E12.0 woman standing: medium-dark skin tone # emoji-test.txt line #1951 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧍🏾‍♀️ E12.0 woman standing: medium-dark skin tone";
## 1F9CD 1F3FE 200D 2640                      ; minimally-qualified # 🧍🏾‍♀ E12.0 woman standing: medium-dark skin tone # emoji-test.txt line #1952 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FE, 0x200D, 0x2640⟆ 🧍🏾‍♀ E12.0 woman standing: medium-dark skin tone";
## 1F9CD 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧍🏿‍♀️ E12.0 woman standing: dark skin tone # emoji-test.txt line #1953 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧍🏿‍♀️ E12.0 woman standing: dark skin tone";
## 1F9CD 1F3FF 200D 2640                      ; minimally-qualified # 🧍🏿‍♀ E12.0 woman standing: dark skin tone # emoji-test.txt line #1954 Emoji version 13.0
is Uni.new(0x1F9CD, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CD, 0x1F3FF, 0x200D, 0x2640⟆ 🧍🏿‍♀ E12.0 woman standing: dark skin tone";
## 1F9CE 1F3FB                                ; fully-qualified     # 🧎🏻 E12.0 person kneeling: light skin tone # emoji-test.txt line #1956 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FB⟆ 🧎🏻 E12.0 person kneeling: light skin tone";
## 1F9CE 1F3FC                                ; fully-qualified     # 🧎🏼 E12.0 person kneeling: medium-light skin tone # emoji-test.txt line #1957 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FC⟆ 🧎🏼 E12.0 person kneeling: medium-light skin tone";
## 1F9CE 1F3FD                                ; fully-qualified     # 🧎🏽 E12.0 person kneeling: medium skin tone # emoji-test.txt line #1958 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FD⟆ 🧎🏽 E12.0 person kneeling: medium skin tone";
## 1F9CE 1F3FE                                ; fully-qualified     # 🧎🏾 E12.0 person kneeling: medium-dark skin tone # emoji-test.txt line #1959 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FE⟆ 🧎🏾 E12.0 person kneeling: medium-dark skin tone";
## 1F9CE 1F3FF                                ; fully-qualified     # 🧎🏿 E12.0 person kneeling: dark skin tone # emoji-test.txt line #1960 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FF⟆ 🧎🏿 E12.0 person kneeling: dark skin tone";
## 1F9CE 200D 2642 FE0F                       ; fully-qualified     # 🧎‍♂️ E12.0 man kneeling # emoji-test.txt line #1961 Emoji version 13.0
is Uni.new(0x1F9CE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x200D, 0x2642, 0xFE0F⟆ 🧎‍♂️ E12.0 man kneeling";
## 1F9CE 200D 2642                            ; minimally-qualified # 🧎‍♂ E12.0 man kneeling # emoji-test.txt line #1962 Emoji version 13.0
is Uni.new(0x1F9CE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x200D, 0x2642⟆ 🧎‍♂ E12.0 man kneeling";
## 1F9CE 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧎🏻‍♂️ E12.0 man kneeling: light skin tone # emoji-test.txt line #1963 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧎🏻‍♂️ E12.0 man kneeling: light skin tone";
## 1F9CE 1F3FB 200D 2642                      ; minimally-qualified # 🧎🏻‍♂ E12.0 man kneeling: light skin tone # emoji-test.txt line #1964 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FB, 0x200D, 0x2642⟆ 🧎🏻‍♂ E12.0 man kneeling: light skin tone";
## 1F9CE 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧎🏼‍♂️ E12.0 man kneeling: medium-light skin tone # emoji-test.txt line #1965 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧎🏼‍♂️ E12.0 man kneeling: medium-light skin tone";
## 1F9CE 1F3FC 200D 2642                      ; minimally-qualified # 🧎🏼‍♂ E12.0 man kneeling: medium-light skin tone # emoji-test.txt line #1966 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FC, 0x200D, 0x2642⟆ 🧎🏼‍♂ E12.0 man kneeling: medium-light skin tone";
## 1F9CE 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧎🏽‍♂️ E12.0 man kneeling: medium skin tone # emoji-test.txt line #1967 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧎🏽‍♂️ E12.0 man kneeling: medium skin tone";
## 1F9CE 1F3FD 200D 2642                      ; minimally-qualified # 🧎🏽‍♂ E12.0 man kneeling: medium skin tone # emoji-test.txt line #1968 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FD, 0x200D, 0x2642⟆ 🧎🏽‍♂ E12.0 man kneeling: medium skin tone";
## 1F9CE 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧎🏾‍♂️ E12.0 man kneeling: medium-dark skin tone # emoji-test.txt line #1969 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧎🏾‍♂️ E12.0 man kneeling: medium-dark skin tone";
## 1F9CE 1F3FE 200D 2642                      ; minimally-qualified # 🧎🏾‍♂ E12.0 man kneeling: medium-dark skin tone # emoji-test.txt line #1970 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FE, 0x200D, 0x2642⟆ 🧎🏾‍♂ E12.0 man kneeling: medium-dark skin tone";
## 1F9CE 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧎🏿‍♂️ E12.0 man kneeling: dark skin tone # emoji-test.txt line #1971 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧎🏿‍♂️ E12.0 man kneeling: dark skin tone";
## 1F9CE 1F3FF 200D 2642                      ; minimally-qualified # 🧎🏿‍♂ E12.0 man kneeling: dark skin tone # emoji-test.txt line #1972 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FF, 0x200D, 0x2642⟆ 🧎🏿‍♂ E12.0 man kneeling: dark skin tone";
## 1F9CE 200D 2640 FE0F                       ; fully-qualified     # 🧎‍♀️ E12.0 woman kneeling # emoji-test.txt line #1973 Emoji version 13.0
is Uni.new(0x1F9CE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x200D, 0x2640, 0xFE0F⟆ 🧎‍♀️ E12.0 woman kneeling";
## 1F9CE 200D 2640                            ; minimally-qualified # 🧎‍♀ E12.0 woman kneeling # emoji-test.txt line #1974 Emoji version 13.0
is Uni.new(0x1F9CE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x200D, 0x2640⟆ 🧎‍♀ E12.0 woman kneeling";
## 1F9CE 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧎🏻‍♀️ E12.0 woman kneeling: light skin tone # emoji-test.txt line #1975 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧎🏻‍♀️ E12.0 woman kneeling: light skin tone";
## 1F9CE 1F3FB 200D 2640                      ; minimally-qualified # 🧎🏻‍♀ E12.0 woman kneeling: light skin tone # emoji-test.txt line #1976 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FB, 0x200D, 0x2640⟆ 🧎🏻‍♀ E12.0 woman kneeling: light skin tone";
## 1F9CE 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧎🏼‍♀️ E12.0 woman kneeling: medium-light skin tone # emoji-test.txt line #1977 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧎🏼‍♀️ E12.0 woman kneeling: medium-light skin tone";
## 1F9CE 1F3FC 200D 2640                      ; minimally-qualified # 🧎🏼‍♀ E12.0 woman kneeling: medium-light skin tone # emoji-test.txt line #1978 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FC, 0x200D, 0x2640⟆ 🧎🏼‍♀ E12.0 woman kneeling: medium-light skin tone";
## 1F9CE 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧎🏽‍♀️ E12.0 woman kneeling: medium skin tone # emoji-test.txt line #1979 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧎🏽‍♀️ E12.0 woman kneeling: medium skin tone";
## 1F9CE 1F3FD 200D 2640                      ; minimally-qualified # 🧎🏽‍♀ E12.0 woman kneeling: medium skin tone # emoji-test.txt line #1980 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FD, 0x200D, 0x2640⟆ 🧎🏽‍♀ E12.0 woman kneeling: medium skin tone";
## 1F9CE 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧎🏾‍♀️ E12.0 woman kneeling: medium-dark skin tone # emoji-test.txt line #1981 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧎🏾‍♀️ E12.0 woman kneeling: medium-dark skin tone";
## 1F9CE 1F3FE 200D 2640                      ; minimally-qualified # 🧎🏾‍♀ E12.0 woman kneeling: medium-dark skin tone # emoji-test.txt line #1982 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FE, 0x200D, 0x2640⟆ 🧎🏾‍♀ E12.0 woman kneeling: medium-dark skin tone";
## 1F9CE 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧎🏿‍♀️ E12.0 woman kneeling: dark skin tone # emoji-test.txt line #1983 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧎🏿‍♀️ E12.0 woman kneeling: dark skin tone";
## 1F9CE 1F3FF 200D 2640                      ; minimally-qualified # 🧎🏿‍♀ E12.0 woman kneeling: dark skin tone # emoji-test.txt line #1984 Emoji version 13.0
is Uni.new(0x1F9CE, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9CE, 0x1F3FF, 0x200D, 0x2640⟆ 🧎🏿‍♀ E12.0 woman kneeling: dark skin tone";
## 1F9D1 200D 1F9AF                           ; fully-qualified     # 🧑‍🦯 E12.1 person with white cane # emoji-test.txt line #1985 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F9AF⟆ 🧑‍🦯 E12.1 person with white cane";
## 1F9D1 1F3FB 200D 1F9AF                     ; fully-qualified     # 🧑🏻‍🦯 E12.1 person with white cane: light skin tone # emoji-test.txt line #1986 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F9AF⟆ 🧑🏻‍🦯 E12.1 person with white cane: light skin tone";
## 1F9D1 1F3FC 200D 1F9AF                     ; fully-qualified     # 🧑🏼‍🦯 E12.1 person with white cane: medium-light skin tone # emoji-test.txt line #1987 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F9AF⟆ 🧑🏼‍🦯 E12.1 person with white cane: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F9AF                     ; fully-qualified     # 🧑🏽‍🦯 E12.1 person with white cane: medium skin tone # emoji-test.txt line #1988 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F9AF⟆ 🧑🏽‍🦯 E12.1 person with white cane: medium skin tone";
## 1F9D1 1F3FE 200D 1F9AF                     ; fully-qualified     # 🧑🏾‍🦯 E12.1 person with white cane: medium-dark skin tone # emoji-test.txt line #1989 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F9AF⟆ 🧑🏾‍🦯 E12.1 person with white cane: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F9AF                     ; fully-qualified     # 🧑🏿‍🦯 E12.1 person with white cane: dark skin tone # emoji-test.txt line #1990 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F9AF⟆ 🧑🏿‍🦯 E12.1 person with white cane: dark skin tone";
## 1F468 200D 1F9AF                           ; fully-qualified     # 👨‍🦯 E12.0 man with white cane # emoji-test.txt line #1991 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F9AF⟆ 👨‍🦯 E12.0 man with white cane";
## 1F468 1F3FB 200D 1F9AF                     ; fully-qualified     # 👨🏻‍🦯 E12.0 man with white cane: light skin tone # emoji-test.txt line #1992 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F9AF⟆ 👨🏻‍🦯 E12.0 man with white cane: light skin tone";
## 1F468 1F3FC 200D 1F9AF                     ; fully-qualified     # 👨🏼‍🦯 E12.0 man with white cane: medium-light skin tone # emoji-test.txt line #1993 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F9AF⟆ 👨🏼‍🦯 E12.0 man with white cane: medium-light skin tone";
## 1F468 1F3FD 200D 1F9AF                     ; fully-qualified     # 👨🏽‍🦯 E12.0 man with white cane: medium skin tone # emoji-test.txt line #1994 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F9AF⟆ 👨🏽‍🦯 E12.0 man with white cane: medium skin tone";
## 1F468 1F3FE 200D 1F9AF                     ; fully-qualified     # 👨🏾‍🦯 E12.0 man with white cane: medium-dark skin tone # emoji-test.txt line #1995 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F9AF⟆ 👨🏾‍🦯 E12.0 man with white cane: medium-dark skin tone";
## 1F468 1F3FF 200D 1F9AF                     ; fully-qualified     # 👨🏿‍🦯 E12.0 man with white cane: dark skin tone # emoji-test.txt line #1996 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F9AF⟆ 👨🏿‍🦯 E12.0 man with white cane: dark skin tone";
## 1F469 200D 1F9AF                           ; fully-qualified     # 👩‍🦯 E12.0 woman with white cane # emoji-test.txt line #1997 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F9AF⟆ 👩‍🦯 E12.0 woman with white cane";
## 1F469 1F3FB 200D 1F9AF                     ; fully-qualified     # 👩🏻‍🦯 E12.0 woman with white cane: light skin tone # emoji-test.txt line #1998 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F9AF⟆ 👩🏻‍🦯 E12.0 woman with white cane: light skin tone";
## 1F469 1F3FC 200D 1F9AF                     ; fully-qualified     # 👩🏼‍🦯 E12.0 woman with white cane: medium-light skin tone # emoji-test.txt line #1999 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F9AF⟆ 👩🏼‍🦯 E12.0 woman with white cane: medium-light skin tone";
## 1F469 1F3FD 200D 1F9AF                     ; fully-qualified     # 👩🏽‍🦯 E12.0 woman with white cane: medium skin tone # emoji-test.txt line #2000 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F9AF⟆ 👩🏽‍🦯 E12.0 woman with white cane: medium skin tone";
## 1F469 1F3FE 200D 1F9AF                     ; fully-qualified     # 👩🏾‍🦯 E12.0 woman with white cane: medium-dark skin tone # emoji-test.txt line #2001 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F9AF⟆ 👩🏾‍🦯 E12.0 woman with white cane: medium-dark skin tone";
## 1F469 1F3FF 200D 1F9AF                     ; fully-qualified     # 👩🏿‍🦯 E12.0 woman with white cane: dark skin tone # emoji-test.txt line #2002 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F9AF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F9AF⟆ 👩🏿‍🦯 E12.0 woman with white cane: dark skin tone";
## 1F9D1 200D 1F9BC                           ; fully-qualified     # 🧑‍🦼 E12.1 person in motorized wheelchair # emoji-test.txt line #2003 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F9BC⟆ 🧑‍🦼 E12.1 person in motorized wheelchair";
## 1F9D1 1F3FB 200D 1F9BC                     ; fully-qualified     # 🧑🏻‍🦼 E12.1 person in motorized wheelchair: light skin tone # emoji-test.txt line #2004 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F9BC⟆ 🧑🏻‍🦼 E12.1 person in motorized wheelchair: light skin tone";
## 1F9D1 1F3FC 200D 1F9BC                     ; fully-qualified     # 🧑🏼‍🦼 E12.1 person in motorized wheelchair: medium-light skin tone # emoji-test.txt line #2005 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F9BC⟆ 🧑🏼‍🦼 E12.1 person in motorized wheelchair: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F9BC                     ; fully-qualified     # 🧑🏽‍🦼 E12.1 person in motorized wheelchair: medium skin tone # emoji-test.txt line #2006 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F9BC⟆ 🧑🏽‍🦼 E12.1 person in motorized wheelchair: medium skin tone";
## 1F9D1 1F3FE 200D 1F9BC                     ; fully-qualified     # 🧑🏾‍🦼 E12.1 person in motorized wheelchair: medium-dark skin tone # emoji-test.txt line #2007 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F9BC⟆ 🧑🏾‍🦼 E12.1 person in motorized wheelchair: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F9BC                     ; fully-qualified     # 🧑🏿‍🦼 E12.1 person in motorized wheelchair: dark skin tone # emoji-test.txt line #2008 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F9BC⟆ 🧑🏿‍🦼 E12.1 person in motorized wheelchair: dark skin tone";
## 1F468 200D 1F9BC                           ; fully-qualified     # 👨‍🦼 E12.0 man in motorized wheelchair # emoji-test.txt line #2009 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F9BC⟆ 👨‍🦼 E12.0 man in motorized wheelchair";
## 1F468 1F3FB 200D 1F9BC                     ; fully-qualified     # 👨🏻‍🦼 E12.0 man in motorized wheelchair: light skin tone # emoji-test.txt line #2010 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F9BC⟆ 👨🏻‍🦼 E12.0 man in motorized wheelchair: light skin tone";
## 1F468 1F3FC 200D 1F9BC                     ; fully-qualified     # 👨🏼‍🦼 E12.0 man in motorized wheelchair: medium-light skin tone # emoji-test.txt line #2011 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F9BC⟆ 👨🏼‍🦼 E12.0 man in motorized wheelchair: medium-light skin tone";
## 1F468 1F3FD 200D 1F9BC                     ; fully-qualified     # 👨🏽‍🦼 E12.0 man in motorized wheelchair: medium skin tone # emoji-test.txt line #2012 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F9BC⟆ 👨🏽‍🦼 E12.0 man in motorized wheelchair: medium skin tone";
## 1F468 1F3FE 200D 1F9BC                     ; fully-qualified     # 👨🏾‍🦼 E12.0 man in motorized wheelchair: medium-dark skin tone # emoji-test.txt line #2013 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F9BC⟆ 👨🏾‍🦼 E12.0 man in motorized wheelchair: medium-dark skin tone";
## 1F468 1F3FF 200D 1F9BC                     ; fully-qualified     # 👨🏿‍🦼 E12.0 man in motorized wheelchair: dark skin tone # emoji-test.txt line #2014 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F9BC⟆ 👨🏿‍🦼 E12.0 man in motorized wheelchair: dark skin tone";
## 1F469 200D 1F9BC                           ; fully-qualified     # 👩‍🦼 E12.0 woman in motorized wheelchair # emoji-test.txt line #2015 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F9BC⟆ 👩‍🦼 E12.0 woman in motorized wheelchair";
## 1F469 1F3FB 200D 1F9BC                     ; fully-qualified     # 👩🏻‍🦼 E12.0 woman in motorized wheelchair: light skin tone # emoji-test.txt line #2016 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F9BC⟆ 👩🏻‍🦼 E12.0 woman in motorized wheelchair: light skin tone";
## 1F469 1F3FC 200D 1F9BC                     ; fully-qualified     # 👩🏼‍🦼 E12.0 woman in motorized wheelchair: medium-light skin tone # emoji-test.txt line #2017 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F9BC⟆ 👩🏼‍🦼 E12.0 woman in motorized wheelchair: medium-light skin tone";
## 1F469 1F3FD 200D 1F9BC                     ; fully-qualified     # 👩🏽‍🦼 E12.0 woman in motorized wheelchair: medium skin tone # emoji-test.txt line #2018 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F9BC⟆ 👩🏽‍🦼 E12.0 woman in motorized wheelchair: medium skin tone";
## 1F469 1F3FE 200D 1F9BC                     ; fully-qualified     # 👩🏾‍🦼 E12.0 woman in motorized wheelchair: medium-dark skin tone # emoji-test.txt line #2019 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F9BC⟆ 👩🏾‍🦼 E12.0 woman in motorized wheelchair: medium-dark skin tone";
## 1F469 1F3FF 200D 1F9BC                     ; fully-qualified     # 👩🏿‍🦼 E12.0 woman in motorized wheelchair: dark skin tone # emoji-test.txt line #2020 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F9BC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F9BC⟆ 👩🏿‍🦼 E12.0 woman in motorized wheelchair: dark skin tone";
## 1F9D1 200D 1F9BD                           ; fully-qualified     # 🧑‍🦽 E12.1 person in manual wheelchair # emoji-test.txt line #2021 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F9BD⟆ 🧑‍🦽 E12.1 person in manual wheelchair";
## 1F9D1 1F3FB 200D 1F9BD                     ; fully-qualified     # 🧑🏻‍🦽 E12.1 person in manual wheelchair: light skin tone # emoji-test.txt line #2022 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F9BD⟆ 🧑🏻‍🦽 E12.1 person in manual wheelchair: light skin tone";
## 1F9D1 1F3FC 200D 1F9BD                     ; fully-qualified     # 🧑🏼‍🦽 E12.1 person in manual wheelchair: medium-light skin tone # emoji-test.txt line #2023 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F9BD⟆ 🧑🏼‍🦽 E12.1 person in manual wheelchair: medium-light skin tone";
## 1F9D1 1F3FD 200D 1F9BD                     ; fully-qualified     # 🧑🏽‍🦽 E12.1 person in manual wheelchair: medium skin tone # emoji-test.txt line #2024 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F9BD⟆ 🧑🏽‍🦽 E12.1 person in manual wheelchair: medium skin tone";
## 1F9D1 1F3FE 200D 1F9BD                     ; fully-qualified     # 🧑🏾‍🦽 E12.1 person in manual wheelchair: medium-dark skin tone # emoji-test.txt line #2025 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F9BD⟆ 🧑🏾‍🦽 E12.1 person in manual wheelchair: medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F9BD                     ; fully-qualified     # 🧑🏿‍🦽 E12.1 person in manual wheelchair: dark skin tone # emoji-test.txt line #2026 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F9BD⟆ 🧑🏿‍🦽 E12.1 person in manual wheelchair: dark skin tone";
## 1F468 200D 1F9BD                           ; fully-qualified     # 👨‍🦽 E12.0 man in manual wheelchair # emoji-test.txt line #2027 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F9BD⟆ 👨‍🦽 E12.0 man in manual wheelchair";
## 1F468 1F3FB 200D 1F9BD                     ; fully-qualified     # 👨🏻‍🦽 E12.0 man in manual wheelchair: light skin tone # emoji-test.txt line #2028 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F9BD⟆ 👨🏻‍🦽 E12.0 man in manual wheelchair: light skin tone";
## 1F468 1F3FC 200D 1F9BD                     ; fully-qualified     # 👨🏼‍🦽 E12.0 man in manual wheelchair: medium-light skin tone # emoji-test.txt line #2029 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F9BD⟆ 👨🏼‍🦽 E12.0 man in manual wheelchair: medium-light skin tone";
## 1F468 1F3FD 200D 1F9BD                     ; fully-qualified     # 👨🏽‍🦽 E12.0 man in manual wheelchair: medium skin tone # emoji-test.txt line #2030 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F9BD⟆ 👨🏽‍🦽 E12.0 man in manual wheelchair: medium skin tone";
## 1F468 1F3FE 200D 1F9BD                     ; fully-qualified     # 👨🏾‍🦽 E12.0 man in manual wheelchair: medium-dark skin tone # emoji-test.txt line #2031 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F9BD⟆ 👨🏾‍🦽 E12.0 man in manual wheelchair: medium-dark skin tone";
## 1F468 1F3FF 200D 1F9BD                     ; fully-qualified     # 👨🏿‍🦽 E12.0 man in manual wheelchair: dark skin tone # emoji-test.txt line #2032 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F9BD⟆ 👨🏿‍🦽 E12.0 man in manual wheelchair: dark skin tone";
## 1F469 200D 1F9BD                           ; fully-qualified     # 👩‍🦽 E12.0 woman in manual wheelchair # emoji-test.txt line #2033 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F9BD⟆ 👩‍🦽 E12.0 woman in manual wheelchair";
## 1F469 1F3FB 200D 1F9BD                     ; fully-qualified     # 👩🏻‍🦽 E12.0 woman in manual wheelchair: light skin tone # emoji-test.txt line #2034 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F9BD⟆ 👩🏻‍🦽 E12.0 woman in manual wheelchair: light skin tone";
## 1F469 1F3FC 200D 1F9BD                     ; fully-qualified     # 👩🏼‍🦽 E12.0 woman in manual wheelchair: medium-light skin tone # emoji-test.txt line #2035 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F9BD⟆ 👩🏼‍🦽 E12.0 woman in manual wheelchair: medium-light skin tone";
## 1F469 1F3FD 200D 1F9BD                     ; fully-qualified     # 👩🏽‍🦽 E12.0 woman in manual wheelchair: medium skin tone # emoji-test.txt line #2036 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F9BD⟆ 👩🏽‍🦽 E12.0 woman in manual wheelchair: medium skin tone";
## 1F469 1F3FE 200D 1F9BD                     ; fully-qualified     # 👩🏾‍🦽 E12.0 woman in manual wheelchair: medium-dark skin tone # emoji-test.txt line #2037 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F9BD⟆ 👩🏾‍🦽 E12.0 woman in manual wheelchair: medium-dark skin tone";
## 1F469 1F3FF 200D 1F9BD                     ; fully-qualified     # 👩🏿‍🦽 E12.0 woman in manual wheelchair: dark skin tone # emoji-test.txt line #2038 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F9BD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F9BD⟆ 👩🏿‍🦽 E12.0 woman in manual wheelchair: dark skin tone";
## 1F3C3 1F3FB                                ; fully-qualified     # 🏃🏻 E1.0 person running: light skin tone # emoji-test.txt line #2040 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FB⟆ 🏃🏻 E1.0 person running: light skin tone";
## 1F3C3 1F3FC                                ; fully-qualified     # 🏃🏼 E1.0 person running: medium-light skin tone # emoji-test.txt line #2041 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FC⟆ 🏃🏼 E1.0 person running: medium-light skin tone";
## 1F3C3 1F3FD                                ; fully-qualified     # 🏃🏽 E1.0 person running: medium skin tone # emoji-test.txt line #2042 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FD⟆ 🏃🏽 E1.0 person running: medium skin tone";
## 1F3C3 1F3FE                                ; fully-qualified     # 🏃🏾 E1.0 person running: medium-dark skin tone # emoji-test.txt line #2043 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FE⟆ 🏃🏾 E1.0 person running: medium-dark skin tone";
## 1F3C3 1F3FF                                ; fully-qualified     # 🏃🏿 E1.0 person running: dark skin tone # emoji-test.txt line #2044 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FF⟆ 🏃🏿 E1.0 person running: dark skin tone";
## 1F3C3 200D 2642 FE0F                       ; fully-qualified     # 🏃‍♂️ E4.0 man running # emoji-test.txt line #2045 Emoji version 13.0
is Uni.new(0x1F3C3, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x200D, 0x2642, 0xFE0F⟆ 🏃‍♂️ E4.0 man running";
## 1F3C3 200D 2642                            ; minimally-qualified # 🏃‍♂ E4.0 man running # emoji-test.txt line #2046 Emoji version 13.0
is Uni.new(0x1F3C3, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x200D, 0x2642⟆ 🏃‍♂ E4.0 man running";
## 1F3C3 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🏃🏻‍♂️ E4.0 man running: light skin tone # emoji-test.txt line #2047 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🏃🏻‍♂️ E4.0 man running: light skin tone";
## 1F3C3 1F3FB 200D 2642                      ; minimally-qualified # 🏃🏻‍♂ E4.0 man running: light skin tone # emoji-test.txt line #2048 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FB, 0x200D, 0x2642⟆ 🏃🏻‍♂ E4.0 man running: light skin tone";
## 1F3C3 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🏃🏼‍♂️ E4.0 man running: medium-light skin tone # emoji-test.txt line #2049 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🏃🏼‍♂️ E4.0 man running: medium-light skin tone";
## 1F3C3 1F3FC 200D 2642                      ; minimally-qualified # 🏃🏼‍♂ E4.0 man running: medium-light skin tone # emoji-test.txt line #2050 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FC, 0x200D, 0x2642⟆ 🏃🏼‍♂ E4.0 man running: medium-light skin tone";
## 1F3C3 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🏃🏽‍♂️ E4.0 man running: medium skin tone # emoji-test.txt line #2051 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🏃🏽‍♂️ E4.0 man running: medium skin tone";
## 1F3C3 1F3FD 200D 2642                      ; minimally-qualified # 🏃🏽‍♂ E4.0 man running: medium skin tone # emoji-test.txt line #2052 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FD, 0x200D, 0x2642⟆ 🏃🏽‍♂ E4.0 man running: medium skin tone";
## 1F3C3 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🏃🏾‍♂️ E4.0 man running: medium-dark skin tone # emoji-test.txt line #2053 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🏃🏾‍♂️ E4.0 man running: medium-dark skin tone";
## 1F3C3 1F3FE 200D 2642                      ; minimally-qualified # 🏃🏾‍♂ E4.0 man running: medium-dark skin tone # emoji-test.txt line #2054 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FE, 0x200D, 0x2642⟆ 🏃🏾‍♂ E4.0 man running: medium-dark skin tone";
## 1F3C3 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🏃🏿‍♂️ E4.0 man running: dark skin tone # emoji-test.txt line #2055 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🏃🏿‍♂️ E4.0 man running: dark skin tone";
## 1F3C3 1F3FF 200D 2642                      ; minimally-qualified # 🏃🏿‍♂ E4.0 man running: dark skin tone # emoji-test.txt line #2056 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FF, 0x200D, 0x2642⟆ 🏃🏿‍♂ E4.0 man running: dark skin tone";
## 1F3C3 200D 2640 FE0F                       ; fully-qualified     # 🏃‍♀️ E4.0 woman running # emoji-test.txt line #2057 Emoji version 13.0
is Uni.new(0x1F3C3, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x200D, 0x2640, 0xFE0F⟆ 🏃‍♀️ E4.0 woman running";
## 1F3C3 200D 2640                            ; minimally-qualified # 🏃‍♀ E4.0 woman running # emoji-test.txt line #2058 Emoji version 13.0
is Uni.new(0x1F3C3, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x200D, 0x2640⟆ 🏃‍♀ E4.0 woman running";
## 1F3C3 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🏃🏻‍♀️ E4.0 woman running: light skin tone # emoji-test.txt line #2059 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🏃🏻‍♀️ E4.0 woman running: light skin tone";
## 1F3C3 1F3FB 200D 2640                      ; minimally-qualified # 🏃🏻‍♀ E4.0 woman running: light skin tone # emoji-test.txt line #2060 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FB, 0x200D, 0x2640⟆ 🏃🏻‍♀ E4.0 woman running: light skin tone";
## 1F3C3 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🏃🏼‍♀️ E4.0 woman running: medium-light skin tone # emoji-test.txt line #2061 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🏃🏼‍♀️ E4.0 woman running: medium-light skin tone";
## 1F3C3 1F3FC 200D 2640                      ; minimally-qualified # 🏃🏼‍♀ E4.0 woman running: medium-light skin tone # emoji-test.txt line #2062 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FC, 0x200D, 0x2640⟆ 🏃🏼‍♀ E4.0 woman running: medium-light skin tone";
## 1F3C3 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🏃🏽‍♀️ E4.0 woman running: medium skin tone # emoji-test.txt line #2063 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🏃🏽‍♀️ E4.0 woman running: medium skin tone";
## 1F3C3 1F3FD 200D 2640                      ; minimally-qualified # 🏃🏽‍♀ E4.0 woman running: medium skin tone # emoji-test.txt line #2064 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FD, 0x200D, 0x2640⟆ 🏃🏽‍♀ E4.0 woman running: medium skin tone";
## 1F3C3 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🏃🏾‍♀️ E4.0 woman running: medium-dark skin tone # emoji-test.txt line #2065 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🏃🏾‍♀️ E4.0 woman running: medium-dark skin tone";
## 1F3C3 1F3FE 200D 2640                      ; minimally-qualified # 🏃🏾‍♀ E4.0 woman running: medium-dark skin tone # emoji-test.txt line #2066 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FE, 0x200D, 0x2640⟆ 🏃🏾‍♀ E4.0 woman running: medium-dark skin tone";
## 1F3C3 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🏃🏿‍♀️ E4.0 woman running: dark skin tone # emoji-test.txt line #2067 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🏃🏿‍♀️ E4.0 woman running: dark skin tone";
## 1F3C3 1F3FF 200D 2640                      ; minimally-qualified # 🏃🏿‍♀ E4.0 woman running: dark skin tone # emoji-test.txt line #2068 Emoji version 13.0
is Uni.new(0x1F3C3, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C3, 0x1F3FF, 0x200D, 0x2640⟆ 🏃🏿‍♀ E4.0 woman running: dark skin tone";
## 1F483 1F3FB                                ; fully-qualified     # 💃🏻 E1.0 woman dancing: light skin tone # emoji-test.txt line #2070 Emoji version 13.0
is Uni.new(0x1F483, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F483, 0x1F3FB⟆ 💃🏻 E1.0 woman dancing: light skin tone";
## 1F483 1F3FC                                ; fully-qualified     # 💃🏼 E1.0 woman dancing: medium-light skin tone # emoji-test.txt line #2071 Emoji version 13.0
is Uni.new(0x1F483, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F483, 0x1F3FC⟆ 💃🏼 E1.0 woman dancing: medium-light skin tone";
## 1F483 1F3FD                                ; fully-qualified     # 💃🏽 E1.0 woman dancing: medium skin tone # emoji-test.txt line #2072 Emoji version 13.0
is Uni.new(0x1F483, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F483, 0x1F3FD⟆ 💃🏽 E1.0 woman dancing: medium skin tone";
## 1F483 1F3FE                                ; fully-qualified     # 💃🏾 E1.0 woman dancing: medium-dark skin tone # emoji-test.txt line #2073 Emoji version 13.0
is Uni.new(0x1F483, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F483, 0x1F3FE⟆ 💃🏾 E1.0 woman dancing: medium-dark skin tone";
## 1F483 1F3FF                                ; fully-qualified     # 💃🏿 E1.0 woman dancing: dark skin tone # emoji-test.txt line #2074 Emoji version 13.0
is Uni.new(0x1F483, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F483, 0x1F3FF⟆ 💃🏿 E1.0 woman dancing: dark skin tone";
## 1F57A 1F3FB                                ; fully-qualified     # 🕺🏻 E3.0 man dancing: light skin tone # emoji-test.txt line #2076 Emoji version 13.0
is Uni.new(0x1F57A, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F57A, 0x1F3FB⟆ 🕺🏻 E3.0 man dancing: light skin tone";
## 1F57A 1F3FC                                ; fully-qualified     # 🕺🏼 E3.0 man dancing: medium-light skin tone # emoji-test.txt line #2077 Emoji version 13.0
is Uni.new(0x1F57A, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F57A, 0x1F3FC⟆ 🕺🏼 E3.0 man dancing: medium-light skin tone";
## 1F57A 1F3FD                                ; fully-qualified     # 🕺🏽 E3.0 man dancing: medium skin tone # emoji-test.txt line #2078 Emoji version 13.0
is Uni.new(0x1F57A, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F57A, 0x1F3FD⟆ 🕺🏽 E3.0 man dancing: medium skin tone";
## 1F57A 1F3FE                                ; fully-qualified     # 🕺🏾 E3.0 man dancing: medium-dark skin tone # emoji-test.txt line #2079 Emoji version 13.0
is Uni.new(0x1F57A, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F57A, 0x1F3FE⟆ 🕺🏾 E3.0 man dancing: medium-dark skin tone";
## 1F57A 1F3FF                                ; fully-qualified     # 🕺🏿 E3.0 man dancing: dark skin tone # emoji-test.txt line #2080 Emoji version 13.0
is Uni.new(0x1F57A, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F57A, 0x1F3FF⟆ 🕺🏿 E3.0 man dancing: dark skin tone";
## 1F574 FE0F                                 ; fully-qualified     # 🕴️ E0.7 person in suit levitating # emoji-test.txt line #2081 Emoji version 13.0
is Uni.new(0x1F574, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F574, 0xFE0F⟆ 🕴️ E0.7 person in suit levitating";
## 1F574 1F3FB                                ; fully-qualified     # 🕴🏻 E4.0 person in suit levitating: light skin tone # emoji-test.txt line #2083 Emoji version 13.0
is Uni.new(0x1F574, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F574, 0x1F3FB⟆ 🕴🏻 E4.0 person in suit levitating: light skin tone";
## 1F574 1F3FC                                ; fully-qualified     # 🕴🏼 E4.0 person in suit levitating: medium-light skin tone # emoji-test.txt line #2084 Emoji version 13.0
is Uni.new(0x1F574, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F574, 0x1F3FC⟆ 🕴🏼 E4.0 person in suit levitating: medium-light skin tone";
## 1F574 1F3FD                                ; fully-qualified     # 🕴🏽 E4.0 person in suit levitating: medium skin tone # emoji-test.txt line #2085 Emoji version 13.0
is Uni.new(0x1F574, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F574, 0x1F3FD⟆ 🕴🏽 E4.0 person in suit levitating: medium skin tone";
## 1F574 1F3FE                                ; fully-qualified     # 🕴🏾 E4.0 person in suit levitating: medium-dark skin tone # emoji-test.txt line #2086 Emoji version 13.0
is Uni.new(0x1F574, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F574, 0x1F3FE⟆ 🕴🏾 E4.0 person in suit levitating: medium-dark skin tone";
## 1F574 1F3FF                                ; fully-qualified     # 🕴🏿 E4.0 person in suit levitating: dark skin tone # emoji-test.txt line #2087 Emoji version 13.0
is Uni.new(0x1F574, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F574, 0x1F3FF⟆ 🕴🏿 E4.0 person in suit levitating: dark skin tone";
## 1F46F 200D 2642 FE0F                       ; fully-qualified     # 👯‍♂️ E4.0 men with bunny ears # emoji-test.txt line #2089 Emoji version 13.0
is Uni.new(0x1F46F, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46F, 0x200D, 0x2642, 0xFE0F⟆ 👯‍♂️ E4.0 men with bunny ears";
## 1F46F 200D 2642                            ; minimally-qualified # 👯‍♂ E4.0 men with bunny ears # emoji-test.txt line #2090 Emoji version 13.0
is Uni.new(0x1F46F, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F46F, 0x200D, 0x2642⟆ 👯‍♂ E4.0 men with bunny ears";
## 1F46F 200D 2640 FE0F                       ; fully-qualified     # 👯‍♀️ E4.0 women with bunny ears # emoji-test.txt line #2091 Emoji version 13.0
is Uni.new(0x1F46F, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F46F, 0x200D, 0x2640, 0xFE0F⟆ 👯‍♀️ E4.0 women with bunny ears";
## 1F46F 200D 2640                            ; minimally-qualified # 👯‍♀ E4.0 women with bunny ears # emoji-test.txt line #2092 Emoji version 13.0
is Uni.new(0x1F46F, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F46F, 0x200D, 0x2640⟆ 👯‍♀ E4.0 women with bunny ears";
## 1F9D6 1F3FB                                ; fully-qualified     # 🧖🏻 E5.0 person in steamy room: light skin tone # emoji-test.txt line #2094 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FB⟆ 🧖🏻 E5.0 person in steamy room: light skin tone";
## 1F9D6 1F3FC                                ; fully-qualified     # 🧖🏼 E5.0 person in steamy room: medium-light skin tone # emoji-test.txt line #2095 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FC⟆ 🧖🏼 E5.0 person in steamy room: medium-light skin tone";
## 1F9D6 1F3FD                                ; fully-qualified     # 🧖🏽 E5.0 person in steamy room: medium skin tone # emoji-test.txt line #2096 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FD⟆ 🧖🏽 E5.0 person in steamy room: medium skin tone";
## 1F9D6 1F3FE                                ; fully-qualified     # 🧖🏾 E5.0 person in steamy room: medium-dark skin tone # emoji-test.txt line #2097 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FE⟆ 🧖🏾 E5.0 person in steamy room: medium-dark skin tone";
## 1F9D6 1F3FF                                ; fully-qualified     # 🧖🏿 E5.0 person in steamy room: dark skin tone # emoji-test.txt line #2098 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FF⟆ 🧖🏿 E5.0 person in steamy room: dark skin tone";
## 1F9D6 200D 2642 FE0F                       ; fully-qualified     # 🧖‍♂️ E5.0 man in steamy room # emoji-test.txt line #2099 Emoji version 13.0
is Uni.new(0x1F9D6, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x200D, 0x2642, 0xFE0F⟆ 🧖‍♂️ E5.0 man in steamy room";
## 1F9D6 200D 2642                            ; minimally-qualified # 🧖‍♂ E5.0 man in steamy room # emoji-test.txt line #2100 Emoji version 13.0
is Uni.new(0x1F9D6, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x200D, 0x2642⟆ 🧖‍♂ E5.0 man in steamy room";
## 1F9D6 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧖🏻‍♂️ E5.0 man in steamy room: light skin tone # emoji-test.txt line #2101 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧖🏻‍♂️ E5.0 man in steamy room: light skin tone";
## 1F9D6 1F3FB 200D 2642                      ; minimally-qualified # 🧖🏻‍♂ E5.0 man in steamy room: light skin tone # emoji-test.txt line #2102 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FB, 0x200D, 0x2642⟆ 🧖🏻‍♂ E5.0 man in steamy room: light skin tone";
## 1F9D6 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧖🏼‍♂️ E5.0 man in steamy room: medium-light skin tone # emoji-test.txt line #2103 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧖🏼‍♂️ E5.0 man in steamy room: medium-light skin tone";
## 1F9D6 1F3FC 200D 2642                      ; minimally-qualified # 🧖🏼‍♂ E5.0 man in steamy room: medium-light skin tone # emoji-test.txt line #2104 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FC, 0x200D, 0x2642⟆ 🧖🏼‍♂ E5.0 man in steamy room: medium-light skin tone";
## 1F9D6 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧖🏽‍♂️ E5.0 man in steamy room: medium skin tone # emoji-test.txt line #2105 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧖🏽‍♂️ E5.0 man in steamy room: medium skin tone";
## 1F9D6 1F3FD 200D 2642                      ; minimally-qualified # 🧖🏽‍♂ E5.0 man in steamy room: medium skin tone # emoji-test.txt line #2106 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FD, 0x200D, 0x2642⟆ 🧖🏽‍♂ E5.0 man in steamy room: medium skin tone";
## 1F9D6 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧖🏾‍♂️ E5.0 man in steamy room: medium-dark skin tone # emoji-test.txt line #2107 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧖🏾‍♂️ E5.0 man in steamy room: medium-dark skin tone";
## 1F9D6 1F3FE 200D 2642                      ; minimally-qualified # 🧖🏾‍♂ E5.0 man in steamy room: medium-dark skin tone # emoji-test.txt line #2108 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FE, 0x200D, 0x2642⟆ 🧖🏾‍♂ E5.0 man in steamy room: medium-dark skin tone";
## 1F9D6 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧖🏿‍♂️ E5.0 man in steamy room: dark skin tone # emoji-test.txt line #2109 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧖🏿‍♂️ E5.0 man in steamy room: dark skin tone";
## 1F9D6 1F3FF 200D 2642                      ; minimally-qualified # 🧖🏿‍♂ E5.0 man in steamy room: dark skin tone # emoji-test.txt line #2110 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FF, 0x200D, 0x2642⟆ 🧖🏿‍♂ E5.0 man in steamy room: dark skin tone";
## 1F9D6 200D 2640 FE0F                       ; fully-qualified     # 🧖‍♀️ E5.0 woman in steamy room # emoji-test.txt line #2111 Emoji version 13.0
is Uni.new(0x1F9D6, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x200D, 0x2640, 0xFE0F⟆ 🧖‍♀️ E5.0 woman in steamy room";
## 1F9D6 200D 2640                            ; minimally-qualified # 🧖‍♀ E5.0 woman in steamy room # emoji-test.txt line #2112 Emoji version 13.0
is Uni.new(0x1F9D6, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x200D, 0x2640⟆ 🧖‍♀ E5.0 woman in steamy room";
## 1F9D6 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧖🏻‍♀️ E5.0 woman in steamy room: light skin tone # emoji-test.txt line #2113 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧖🏻‍♀️ E5.0 woman in steamy room: light skin tone";
## 1F9D6 1F3FB 200D 2640                      ; minimally-qualified # 🧖🏻‍♀ E5.0 woman in steamy room: light skin tone # emoji-test.txt line #2114 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FB, 0x200D, 0x2640⟆ 🧖🏻‍♀ E5.0 woman in steamy room: light skin tone";
## 1F9D6 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧖🏼‍♀️ E5.0 woman in steamy room: medium-light skin tone # emoji-test.txt line #2115 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧖🏼‍♀️ E5.0 woman in steamy room: medium-light skin tone";
## 1F9D6 1F3FC 200D 2640                      ; minimally-qualified # 🧖🏼‍♀ E5.0 woman in steamy room: medium-light skin tone # emoji-test.txt line #2116 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FC, 0x200D, 0x2640⟆ 🧖🏼‍♀ E5.0 woman in steamy room: medium-light skin tone";
## 1F9D6 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧖🏽‍♀️ E5.0 woman in steamy room: medium skin tone # emoji-test.txt line #2117 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧖🏽‍♀️ E5.0 woman in steamy room: medium skin tone";
## 1F9D6 1F3FD 200D 2640                      ; minimally-qualified # 🧖🏽‍♀ E5.0 woman in steamy room: medium skin tone # emoji-test.txt line #2118 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FD, 0x200D, 0x2640⟆ 🧖🏽‍♀ E5.0 woman in steamy room: medium skin tone";
## 1F9D6 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧖🏾‍♀️ E5.0 woman in steamy room: medium-dark skin tone # emoji-test.txt line #2119 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧖🏾‍♀️ E5.0 woman in steamy room: medium-dark skin tone";
## 1F9D6 1F3FE 200D 2640                      ; minimally-qualified # 🧖🏾‍♀ E5.0 woman in steamy room: medium-dark skin tone # emoji-test.txt line #2120 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FE, 0x200D, 0x2640⟆ 🧖🏾‍♀ E5.0 woman in steamy room: medium-dark skin tone";
## 1F9D6 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧖🏿‍♀️ E5.0 woman in steamy room: dark skin tone # emoji-test.txt line #2121 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧖🏿‍♀️ E5.0 woman in steamy room: dark skin tone";
## 1F9D6 1F3FF 200D 2640                      ; minimally-qualified # 🧖🏿‍♀ E5.0 woman in steamy room: dark skin tone # emoji-test.txt line #2122 Emoji version 13.0
is Uni.new(0x1F9D6, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D6, 0x1F3FF, 0x200D, 0x2640⟆ 🧖🏿‍♀ E5.0 woman in steamy room: dark skin tone";
## 1F9D7 1F3FB                                ; fully-qualified     # 🧗🏻 E5.0 person climbing: light skin tone # emoji-test.txt line #2124 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FB⟆ 🧗🏻 E5.0 person climbing: light skin tone";
## 1F9D7 1F3FC                                ; fully-qualified     # 🧗🏼 E5.0 person climbing: medium-light skin tone # emoji-test.txt line #2125 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FC⟆ 🧗🏼 E5.0 person climbing: medium-light skin tone";
## 1F9D7 1F3FD                                ; fully-qualified     # 🧗🏽 E5.0 person climbing: medium skin tone # emoji-test.txt line #2126 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FD⟆ 🧗🏽 E5.0 person climbing: medium skin tone";
## 1F9D7 1F3FE                                ; fully-qualified     # 🧗🏾 E5.0 person climbing: medium-dark skin tone # emoji-test.txt line #2127 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FE⟆ 🧗🏾 E5.0 person climbing: medium-dark skin tone";
## 1F9D7 1F3FF                                ; fully-qualified     # 🧗🏿 E5.0 person climbing: dark skin tone # emoji-test.txt line #2128 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FF⟆ 🧗🏿 E5.0 person climbing: dark skin tone";
## 1F9D7 200D 2642 FE0F                       ; fully-qualified     # 🧗‍♂️ E5.0 man climbing # emoji-test.txt line #2129 Emoji version 13.0
is Uni.new(0x1F9D7, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x200D, 0x2642, 0xFE0F⟆ 🧗‍♂️ E5.0 man climbing";
## 1F9D7 200D 2642                            ; minimally-qualified # 🧗‍♂ E5.0 man climbing # emoji-test.txt line #2130 Emoji version 13.0
is Uni.new(0x1F9D7, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x200D, 0x2642⟆ 🧗‍♂ E5.0 man climbing";
## 1F9D7 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧗🏻‍♂️ E5.0 man climbing: light skin tone # emoji-test.txt line #2131 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧗🏻‍♂️ E5.0 man climbing: light skin tone";
## 1F9D7 1F3FB 200D 2642                      ; minimally-qualified # 🧗🏻‍♂ E5.0 man climbing: light skin tone # emoji-test.txt line #2132 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FB, 0x200D, 0x2642⟆ 🧗🏻‍♂ E5.0 man climbing: light skin tone";
## 1F9D7 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧗🏼‍♂️ E5.0 man climbing: medium-light skin tone # emoji-test.txt line #2133 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧗🏼‍♂️ E5.0 man climbing: medium-light skin tone";
## 1F9D7 1F3FC 200D 2642                      ; minimally-qualified # 🧗🏼‍♂ E5.0 man climbing: medium-light skin tone # emoji-test.txt line #2134 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FC, 0x200D, 0x2642⟆ 🧗🏼‍♂ E5.0 man climbing: medium-light skin tone";
## 1F9D7 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧗🏽‍♂️ E5.0 man climbing: medium skin tone # emoji-test.txt line #2135 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧗🏽‍♂️ E5.0 man climbing: medium skin tone";
## 1F9D7 1F3FD 200D 2642                      ; minimally-qualified # 🧗🏽‍♂ E5.0 man climbing: medium skin tone # emoji-test.txt line #2136 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FD, 0x200D, 0x2642⟆ 🧗🏽‍♂ E5.0 man climbing: medium skin tone";
## 1F9D7 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧗🏾‍♂️ E5.0 man climbing: medium-dark skin tone # emoji-test.txt line #2137 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧗🏾‍♂️ E5.0 man climbing: medium-dark skin tone";
## 1F9D7 1F3FE 200D 2642                      ; minimally-qualified # 🧗🏾‍♂ E5.0 man climbing: medium-dark skin tone # emoji-test.txt line #2138 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FE, 0x200D, 0x2642⟆ 🧗🏾‍♂ E5.0 man climbing: medium-dark skin tone";
## 1F9D7 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧗🏿‍♂️ E5.0 man climbing: dark skin tone # emoji-test.txt line #2139 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧗🏿‍♂️ E5.0 man climbing: dark skin tone";
## 1F9D7 1F3FF 200D 2642                      ; minimally-qualified # 🧗🏿‍♂ E5.0 man climbing: dark skin tone # emoji-test.txt line #2140 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FF, 0x200D, 0x2642⟆ 🧗🏿‍♂ E5.0 man climbing: dark skin tone";
## 1F9D7 200D 2640 FE0F                       ; fully-qualified     # 🧗‍♀️ E5.0 woman climbing # emoji-test.txt line #2141 Emoji version 13.0
is Uni.new(0x1F9D7, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x200D, 0x2640, 0xFE0F⟆ 🧗‍♀️ E5.0 woman climbing";
## 1F9D7 200D 2640                            ; minimally-qualified # 🧗‍♀ E5.0 woman climbing # emoji-test.txt line #2142 Emoji version 13.0
is Uni.new(0x1F9D7, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x200D, 0x2640⟆ 🧗‍♀ E5.0 woman climbing";
## 1F9D7 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧗🏻‍♀️ E5.0 woman climbing: light skin tone # emoji-test.txt line #2143 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧗🏻‍♀️ E5.0 woman climbing: light skin tone";
## 1F9D7 1F3FB 200D 2640                      ; minimally-qualified # 🧗🏻‍♀ E5.0 woman climbing: light skin tone # emoji-test.txt line #2144 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FB, 0x200D, 0x2640⟆ 🧗🏻‍♀ E5.0 woman climbing: light skin tone";
## 1F9D7 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧗🏼‍♀️ E5.0 woman climbing: medium-light skin tone # emoji-test.txt line #2145 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧗🏼‍♀️ E5.0 woman climbing: medium-light skin tone";
## 1F9D7 1F3FC 200D 2640                      ; minimally-qualified # 🧗🏼‍♀ E5.0 woman climbing: medium-light skin tone # emoji-test.txt line #2146 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FC, 0x200D, 0x2640⟆ 🧗🏼‍♀ E5.0 woman climbing: medium-light skin tone";
## 1F9D7 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧗🏽‍♀️ E5.0 woman climbing: medium skin tone # emoji-test.txt line #2147 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧗🏽‍♀️ E5.0 woman climbing: medium skin tone";
## 1F9D7 1F3FD 200D 2640                      ; minimally-qualified # 🧗🏽‍♀ E5.0 woman climbing: medium skin tone # emoji-test.txt line #2148 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FD, 0x200D, 0x2640⟆ 🧗🏽‍♀ E5.0 woman climbing: medium skin tone";
## 1F9D7 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧗🏾‍♀️ E5.0 woman climbing: medium-dark skin tone # emoji-test.txt line #2149 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧗🏾‍♀️ E5.0 woman climbing: medium-dark skin tone";
## 1F9D7 1F3FE 200D 2640                      ; minimally-qualified # 🧗🏾‍♀ E5.0 woman climbing: medium-dark skin tone # emoji-test.txt line #2150 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FE, 0x200D, 0x2640⟆ 🧗🏾‍♀ E5.0 woman climbing: medium-dark skin tone";
## 1F9D7 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧗🏿‍♀️ E5.0 woman climbing: dark skin tone # emoji-test.txt line #2151 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧗🏿‍♀️ E5.0 woman climbing: dark skin tone";
## 1F9D7 1F3FF 200D 2640                      ; minimally-qualified # 🧗🏿‍♀ E5.0 woman climbing: dark skin tone # emoji-test.txt line #2152 Emoji version 13.0
is Uni.new(0x1F9D7, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D7, 0x1F3FF, 0x200D, 0x2640⟆ 🧗🏿‍♀ E5.0 woman climbing: dark skin tone";
## 1F3C7 1F3FB                                ; fully-qualified     # 🏇🏻 E1.0 horse racing: light skin tone # emoji-test.txt line #2157 Emoji version 13.0
is Uni.new(0x1F3C7, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F3C7, 0x1F3FB⟆ 🏇🏻 E1.0 horse racing: light skin tone";
## 1F3C7 1F3FC                                ; fully-qualified     # 🏇🏼 E1.0 horse racing: medium-light skin tone # emoji-test.txt line #2158 Emoji version 13.0
is Uni.new(0x1F3C7, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F3C7, 0x1F3FC⟆ 🏇🏼 E1.0 horse racing: medium-light skin tone";
## 1F3C7 1F3FD                                ; fully-qualified     # 🏇🏽 E1.0 horse racing: medium skin tone # emoji-test.txt line #2159 Emoji version 13.0
is Uni.new(0x1F3C7, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F3C7, 0x1F3FD⟆ 🏇🏽 E1.0 horse racing: medium skin tone";
## 1F3C7 1F3FE                                ; fully-qualified     # 🏇🏾 E1.0 horse racing: medium-dark skin tone # emoji-test.txt line #2160 Emoji version 13.0
is Uni.new(0x1F3C7, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F3C7, 0x1F3FE⟆ 🏇🏾 E1.0 horse racing: medium-dark skin tone";
## 1F3C7 1F3FF                                ; fully-qualified     # 🏇🏿 E1.0 horse racing: dark skin tone # emoji-test.txt line #2161 Emoji version 13.0
is Uni.new(0x1F3C7, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F3C7, 0x1F3FF⟆ 🏇🏿 E1.0 horse racing: dark skin tone";
## 26F7 FE0F                                  ; fully-qualified     # ⛷️ E0.7 skier # emoji-test.txt line #2162 Emoji version 13.0
is Uni.new(0x26F7, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F7, 0xFE0F⟆ ⛷️ E0.7 skier";
## 1F3C2 1F3FB                                ; fully-qualified     # 🏂🏻 E1.0 snowboarder: light skin tone # emoji-test.txt line #2165 Emoji version 13.0
is Uni.new(0x1F3C2, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F3C2, 0x1F3FB⟆ 🏂🏻 E1.0 snowboarder: light skin tone";
## 1F3C2 1F3FC                                ; fully-qualified     # 🏂🏼 E1.0 snowboarder: medium-light skin tone # emoji-test.txt line #2166 Emoji version 13.0
is Uni.new(0x1F3C2, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F3C2, 0x1F3FC⟆ 🏂🏼 E1.0 snowboarder: medium-light skin tone";
## 1F3C2 1F3FD                                ; fully-qualified     # 🏂🏽 E1.0 snowboarder: medium skin tone # emoji-test.txt line #2167 Emoji version 13.0
is Uni.new(0x1F3C2, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F3C2, 0x1F3FD⟆ 🏂🏽 E1.0 snowboarder: medium skin tone";
## 1F3C2 1F3FE                                ; fully-qualified     # 🏂🏾 E1.0 snowboarder: medium-dark skin tone # emoji-test.txt line #2168 Emoji version 13.0
is Uni.new(0x1F3C2, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F3C2, 0x1F3FE⟆ 🏂🏾 E1.0 snowboarder: medium-dark skin tone";
## 1F3C2 1F3FF                                ; fully-qualified     # 🏂🏿 E1.0 snowboarder: dark skin tone # emoji-test.txt line #2169 Emoji version 13.0
is Uni.new(0x1F3C2, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F3C2, 0x1F3FF⟆ 🏂🏿 E1.0 snowboarder: dark skin tone";
## 1F3CC FE0F                                 ; fully-qualified     # 🏌️ E0.7 person golfing # emoji-test.txt line #2170 Emoji version 13.0
is Uni.new(0x1F3CC, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0xFE0F⟆ 🏌️ E0.7 person golfing";
## 1F3CC 1F3FB                                ; fully-qualified     # 🏌🏻 E4.0 person golfing: light skin tone # emoji-test.txt line #2172 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FB⟆ 🏌🏻 E4.0 person golfing: light skin tone";
## 1F3CC 1F3FC                                ; fully-qualified     # 🏌🏼 E4.0 person golfing: medium-light skin tone # emoji-test.txt line #2173 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FC⟆ 🏌🏼 E4.0 person golfing: medium-light skin tone";
## 1F3CC 1F3FD                                ; fully-qualified     # 🏌🏽 E4.0 person golfing: medium skin tone # emoji-test.txt line #2174 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FD⟆ 🏌🏽 E4.0 person golfing: medium skin tone";
## 1F3CC 1F3FE                                ; fully-qualified     # 🏌🏾 E4.0 person golfing: medium-dark skin tone # emoji-test.txt line #2175 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FE⟆ 🏌🏾 E4.0 person golfing: medium-dark skin tone";
## 1F3CC 1F3FF                                ; fully-qualified     # 🏌🏿 E4.0 person golfing: dark skin tone # emoji-test.txt line #2176 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FF⟆ 🏌🏿 E4.0 person golfing: dark skin tone";
## 1F3CC FE0F 200D 2642 FE0F                  ; fully-qualified     # 🏌️‍♂️ E4.0 man golfing # emoji-test.txt line #2177 Emoji version 13.0
is Uni.new(0x1F3CC, 0xFE0F, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0xFE0F, 0x200D, 0x2642, 0xFE0F⟆ 🏌️‍♂️ E4.0 man golfing";
## 1F3CC 200D 2642 FE0F                       ; unqualified         # 🏌‍♂️ E4.0 man golfing # emoji-test.txt line #2178 Emoji version 13.0
is Uni.new(0x1F3CC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x200D, 0x2642, 0xFE0F⟆ 🏌‍♂️ E4.0 man golfing";
## 1F3CC FE0F 200D 2642                       ; unqualified         # 🏌️‍♂ E4.0 man golfing # emoji-test.txt line #2179 Emoji version 13.0
is Uni.new(0x1F3CC, 0xFE0F, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CC, 0xFE0F, 0x200D, 0x2642⟆ 🏌️‍♂ E4.0 man golfing";
## 1F3CC 200D 2642                            ; unqualified         # 🏌‍♂ E4.0 man golfing # emoji-test.txt line #2180 Emoji version 13.0
is Uni.new(0x1F3CC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x200D, 0x2642⟆ 🏌‍♂ E4.0 man golfing";
## 1F3CC 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🏌🏻‍♂️ E4.0 man golfing: light skin tone # emoji-test.txt line #2181 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🏌🏻‍♂️ E4.0 man golfing: light skin tone";
## 1F3CC 1F3FB 200D 2642                      ; minimally-qualified # 🏌🏻‍♂ E4.0 man golfing: light skin tone # emoji-test.txt line #2182 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FB, 0x200D, 0x2642⟆ 🏌🏻‍♂ E4.0 man golfing: light skin tone";
## 1F3CC 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🏌🏼‍♂️ E4.0 man golfing: medium-light skin tone # emoji-test.txt line #2183 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🏌🏼‍♂️ E4.0 man golfing: medium-light skin tone";
## 1F3CC 1F3FC 200D 2642                      ; minimally-qualified # 🏌🏼‍♂ E4.0 man golfing: medium-light skin tone # emoji-test.txt line #2184 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FC, 0x200D, 0x2642⟆ 🏌🏼‍♂ E4.0 man golfing: medium-light skin tone";
## 1F3CC 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🏌🏽‍♂️ E4.0 man golfing: medium skin tone # emoji-test.txt line #2185 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🏌🏽‍♂️ E4.0 man golfing: medium skin tone";
## 1F3CC 1F3FD 200D 2642                      ; minimally-qualified # 🏌🏽‍♂ E4.0 man golfing: medium skin tone # emoji-test.txt line #2186 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FD, 0x200D, 0x2642⟆ 🏌🏽‍♂ E4.0 man golfing: medium skin tone";
## 1F3CC 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🏌🏾‍♂️ E4.0 man golfing: medium-dark skin tone # emoji-test.txt line #2187 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🏌🏾‍♂️ E4.0 man golfing: medium-dark skin tone";
## 1F3CC 1F3FE 200D 2642                      ; minimally-qualified # 🏌🏾‍♂ E4.0 man golfing: medium-dark skin tone # emoji-test.txt line #2188 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FE, 0x200D, 0x2642⟆ 🏌🏾‍♂ E4.0 man golfing: medium-dark skin tone";
## 1F3CC 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🏌🏿‍♂️ E4.0 man golfing: dark skin tone # emoji-test.txt line #2189 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🏌🏿‍♂️ E4.0 man golfing: dark skin tone";
## 1F3CC 1F3FF 200D 2642                      ; minimally-qualified # 🏌🏿‍♂ E4.0 man golfing: dark skin tone # emoji-test.txt line #2190 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FF, 0x200D, 0x2642⟆ 🏌🏿‍♂ E4.0 man golfing: dark skin tone";
## 1F3CC FE0F 200D 2640 FE0F                  ; fully-qualified     # 🏌️‍♀️ E4.0 woman golfing # emoji-test.txt line #2191 Emoji version 13.0
is Uni.new(0x1F3CC, 0xFE0F, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0xFE0F, 0x200D, 0x2640, 0xFE0F⟆ 🏌️‍♀️ E4.0 woman golfing";
## 1F3CC 200D 2640 FE0F                       ; unqualified         # 🏌‍♀️ E4.0 woman golfing # emoji-test.txt line #2192 Emoji version 13.0
is Uni.new(0x1F3CC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x200D, 0x2640, 0xFE0F⟆ 🏌‍♀️ E4.0 woman golfing";
## 1F3CC FE0F 200D 2640                       ; unqualified         # 🏌️‍♀ E4.0 woman golfing # emoji-test.txt line #2193 Emoji version 13.0
is Uni.new(0x1F3CC, 0xFE0F, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CC, 0xFE0F, 0x200D, 0x2640⟆ 🏌️‍♀ E4.0 woman golfing";
## 1F3CC 200D 2640                            ; unqualified         # 🏌‍♀ E4.0 woman golfing # emoji-test.txt line #2194 Emoji version 13.0
is Uni.new(0x1F3CC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x200D, 0x2640⟆ 🏌‍♀ E4.0 woman golfing";
## 1F3CC 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🏌🏻‍♀️ E4.0 woman golfing: light skin tone # emoji-test.txt line #2195 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🏌🏻‍♀️ E4.0 woman golfing: light skin tone";
## 1F3CC 1F3FB 200D 2640                      ; minimally-qualified # 🏌🏻‍♀ E4.0 woman golfing: light skin tone # emoji-test.txt line #2196 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FB, 0x200D, 0x2640⟆ 🏌🏻‍♀ E4.0 woman golfing: light skin tone";
## 1F3CC 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🏌🏼‍♀️ E4.0 woman golfing: medium-light skin tone # emoji-test.txt line #2197 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🏌🏼‍♀️ E4.0 woman golfing: medium-light skin tone";
## 1F3CC 1F3FC 200D 2640                      ; minimally-qualified # 🏌🏼‍♀ E4.0 woman golfing: medium-light skin tone # emoji-test.txt line #2198 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FC, 0x200D, 0x2640⟆ 🏌🏼‍♀ E4.0 woman golfing: medium-light skin tone";
## 1F3CC 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🏌🏽‍♀️ E4.0 woman golfing: medium skin tone # emoji-test.txt line #2199 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🏌🏽‍♀️ E4.0 woman golfing: medium skin tone";
## 1F3CC 1F3FD 200D 2640                      ; minimally-qualified # 🏌🏽‍♀ E4.0 woman golfing: medium skin tone # emoji-test.txt line #2200 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FD, 0x200D, 0x2640⟆ 🏌🏽‍♀ E4.0 woman golfing: medium skin tone";
## 1F3CC 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🏌🏾‍♀️ E4.0 woman golfing: medium-dark skin tone # emoji-test.txt line #2201 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🏌🏾‍♀️ E4.0 woman golfing: medium-dark skin tone";
## 1F3CC 1F3FE 200D 2640                      ; minimally-qualified # 🏌🏾‍♀ E4.0 woman golfing: medium-dark skin tone # emoji-test.txt line #2202 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FE, 0x200D, 0x2640⟆ 🏌🏾‍♀ E4.0 woman golfing: medium-dark skin tone";
## 1F3CC 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🏌🏿‍♀️ E4.0 woman golfing: dark skin tone # emoji-test.txt line #2203 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🏌🏿‍♀️ E4.0 woman golfing: dark skin tone";
## 1F3CC 1F3FF 200D 2640                      ; minimally-qualified # 🏌🏿‍♀ E4.0 woman golfing: dark skin tone # emoji-test.txt line #2204 Emoji version 13.0
is Uni.new(0x1F3CC, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CC, 0x1F3FF, 0x200D, 0x2640⟆ 🏌🏿‍♀ E4.0 woman golfing: dark skin tone";
## 1F3C4 1F3FB                                ; fully-qualified     # 🏄🏻 E1.0 person surfing: light skin tone # emoji-test.txt line #2206 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FB⟆ 🏄🏻 E1.0 person surfing: light skin tone";
## 1F3C4 1F3FC                                ; fully-qualified     # 🏄🏼 E1.0 person surfing: medium-light skin tone # emoji-test.txt line #2207 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FC⟆ 🏄🏼 E1.0 person surfing: medium-light skin tone";
## 1F3C4 1F3FD                                ; fully-qualified     # 🏄🏽 E1.0 person surfing: medium skin tone # emoji-test.txt line #2208 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FD⟆ 🏄🏽 E1.0 person surfing: medium skin tone";
## 1F3C4 1F3FE                                ; fully-qualified     # 🏄🏾 E1.0 person surfing: medium-dark skin tone # emoji-test.txt line #2209 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FE⟆ 🏄🏾 E1.0 person surfing: medium-dark skin tone";
## 1F3C4 1F3FF                                ; fully-qualified     # 🏄🏿 E1.0 person surfing: dark skin tone # emoji-test.txt line #2210 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FF⟆ 🏄🏿 E1.0 person surfing: dark skin tone";
## 1F3C4 200D 2642 FE0F                       ; fully-qualified     # 🏄‍♂️ E4.0 man surfing # emoji-test.txt line #2211 Emoji version 13.0
is Uni.new(0x1F3C4, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x200D, 0x2642, 0xFE0F⟆ 🏄‍♂️ E4.0 man surfing";
## 1F3C4 200D 2642                            ; minimally-qualified # 🏄‍♂ E4.0 man surfing # emoji-test.txt line #2212 Emoji version 13.0
is Uni.new(0x1F3C4, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x200D, 0x2642⟆ 🏄‍♂ E4.0 man surfing";
## 1F3C4 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🏄🏻‍♂️ E4.0 man surfing: light skin tone # emoji-test.txt line #2213 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🏄🏻‍♂️ E4.0 man surfing: light skin tone";
## 1F3C4 1F3FB 200D 2642                      ; minimally-qualified # 🏄🏻‍♂ E4.0 man surfing: light skin tone # emoji-test.txt line #2214 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FB, 0x200D, 0x2642⟆ 🏄🏻‍♂ E4.0 man surfing: light skin tone";
## 1F3C4 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🏄🏼‍♂️ E4.0 man surfing: medium-light skin tone # emoji-test.txt line #2215 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🏄🏼‍♂️ E4.0 man surfing: medium-light skin tone";
## 1F3C4 1F3FC 200D 2642                      ; minimally-qualified # 🏄🏼‍♂ E4.0 man surfing: medium-light skin tone # emoji-test.txt line #2216 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FC, 0x200D, 0x2642⟆ 🏄🏼‍♂ E4.0 man surfing: medium-light skin tone";
## 1F3C4 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🏄🏽‍♂️ E4.0 man surfing: medium skin tone # emoji-test.txt line #2217 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🏄🏽‍♂️ E4.0 man surfing: medium skin tone";
## 1F3C4 1F3FD 200D 2642                      ; minimally-qualified # 🏄🏽‍♂ E4.0 man surfing: medium skin tone # emoji-test.txt line #2218 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FD, 0x200D, 0x2642⟆ 🏄🏽‍♂ E4.0 man surfing: medium skin tone";
## 1F3C4 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🏄🏾‍♂️ E4.0 man surfing: medium-dark skin tone # emoji-test.txt line #2219 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🏄🏾‍♂️ E4.0 man surfing: medium-dark skin tone";
## 1F3C4 1F3FE 200D 2642                      ; minimally-qualified # 🏄🏾‍♂ E4.0 man surfing: medium-dark skin tone # emoji-test.txt line #2220 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FE, 0x200D, 0x2642⟆ 🏄🏾‍♂ E4.0 man surfing: medium-dark skin tone";
## 1F3C4 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🏄🏿‍♂️ E4.0 man surfing: dark skin tone # emoji-test.txt line #2221 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🏄🏿‍♂️ E4.0 man surfing: dark skin tone";
## 1F3C4 1F3FF 200D 2642                      ; minimally-qualified # 🏄🏿‍♂ E4.0 man surfing: dark skin tone # emoji-test.txt line #2222 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FF, 0x200D, 0x2642⟆ 🏄🏿‍♂ E4.0 man surfing: dark skin tone";
## 1F3C4 200D 2640 FE0F                       ; fully-qualified     # 🏄‍♀️ E4.0 woman surfing # emoji-test.txt line #2223 Emoji version 13.0
is Uni.new(0x1F3C4, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x200D, 0x2640, 0xFE0F⟆ 🏄‍♀️ E4.0 woman surfing";
## 1F3C4 200D 2640                            ; minimally-qualified # 🏄‍♀ E4.0 woman surfing # emoji-test.txt line #2224 Emoji version 13.0
is Uni.new(0x1F3C4, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x200D, 0x2640⟆ 🏄‍♀ E4.0 woman surfing";
## 1F3C4 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🏄🏻‍♀️ E4.0 woman surfing: light skin tone # emoji-test.txt line #2225 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🏄🏻‍♀️ E4.0 woman surfing: light skin tone";
## 1F3C4 1F3FB 200D 2640                      ; minimally-qualified # 🏄🏻‍♀ E4.0 woman surfing: light skin tone # emoji-test.txt line #2226 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FB, 0x200D, 0x2640⟆ 🏄🏻‍♀ E4.0 woman surfing: light skin tone";
## 1F3C4 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🏄🏼‍♀️ E4.0 woman surfing: medium-light skin tone # emoji-test.txt line #2227 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🏄🏼‍♀️ E4.0 woman surfing: medium-light skin tone";
## 1F3C4 1F3FC 200D 2640                      ; minimally-qualified # 🏄🏼‍♀ E4.0 woman surfing: medium-light skin tone # emoji-test.txt line #2228 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FC, 0x200D, 0x2640⟆ 🏄🏼‍♀ E4.0 woman surfing: medium-light skin tone";
## 1F3C4 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🏄🏽‍♀️ E4.0 woman surfing: medium skin tone # emoji-test.txt line #2229 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🏄🏽‍♀️ E4.0 woman surfing: medium skin tone";
## 1F3C4 1F3FD 200D 2640                      ; minimally-qualified # 🏄🏽‍♀ E4.0 woman surfing: medium skin tone # emoji-test.txt line #2230 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FD, 0x200D, 0x2640⟆ 🏄🏽‍♀ E4.0 woman surfing: medium skin tone";
## 1F3C4 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🏄🏾‍♀️ E4.0 woman surfing: medium-dark skin tone # emoji-test.txt line #2231 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🏄🏾‍♀️ E4.0 woman surfing: medium-dark skin tone";
## 1F3C4 1F3FE 200D 2640                      ; minimally-qualified # 🏄🏾‍♀ E4.0 woman surfing: medium-dark skin tone # emoji-test.txt line #2232 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FE, 0x200D, 0x2640⟆ 🏄🏾‍♀ E4.0 woman surfing: medium-dark skin tone";
## 1F3C4 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🏄🏿‍♀️ E4.0 woman surfing: dark skin tone # emoji-test.txt line #2233 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🏄🏿‍♀️ E4.0 woman surfing: dark skin tone";
## 1F3C4 1F3FF 200D 2640                      ; minimally-qualified # 🏄🏿‍♀ E4.0 woman surfing: dark skin tone # emoji-test.txt line #2234 Emoji version 13.0
is Uni.new(0x1F3C4, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3C4, 0x1F3FF, 0x200D, 0x2640⟆ 🏄🏿‍♀ E4.0 woman surfing: dark skin tone";
## 1F6A3 1F3FB                                ; fully-qualified     # 🚣🏻 E1.0 person rowing boat: light skin tone # emoji-test.txt line #2236 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FB⟆ 🚣🏻 E1.0 person rowing boat: light skin tone";
## 1F6A3 1F3FC                                ; fully-qualified     # 🚣🏼 E1.0 person rowing boat: medium-light skin tone # emoji-test.txt line #2237 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FC⟆ 🚣🏼 E1.0 person rowing boat: medium-light skin tone";
## 1F6A3 1F3FD                                ; fully-qualified     # 🚣🏽 E1.0 person rowing boat: medium skin tone # emoji-test.txt line #2238 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FD⟆ 🚣🏽 E1.0 person rowing boat: medium skin tone";
## 1F6A3 1F3FE                                ; fully-qualified     # 🚣🏾 E1.0 person rowing boat: medium-dark skin tone # emoji-test.txt line #2239 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FE⟆ 🚣🏾 E1.0 person rowing boat: medium-dark skin tone";
## 1F6A3 1F3FF                                ; fully-qualified     # 🚣🏿 E1.0 person rowing boat: dark skin tone # emoji-test.txt line #2240 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FF⟆ 🚣🏿 E1.0 person rowing boat: dark skin tone";
## 1F6A3 200D 2642 FE0F                       ; fully-qualified     # 🚣‍♂️ E4.0 man rowing boat # emoji-test.txt line #2241 Emoji version 13.0
is Uni.new(0x1F6A3, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x200D, 0x2642, 0xFE0F⟆ 🚣‍♂️ E4.0 man rowing boat";
## 1F6A3 200D 2642                            ; minimally-qualified # 🚣‍♂ E4.0 man rowing boat # emoji-test.txt line #2242 Emoji version 13.0
is Uni.new(0x1F6A3, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x200D, 0x2642⟆ 🚣‍♂ E4.0 man rowing boat";
## 1F6A3 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🚣🏻‍♂️ E4.0 man rowing boat: light skin tone # emoji-test.txt line #2243 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🚣🏻‍♂️ E4.0 man rowing boat: light skin tone";
## 1F6A3 1F3FB 200D 2642                      ; minimally-qualified # 🚣🏻‍♂ E4.0 man rowing boat: light skin tone # emoji-test.txt line #2244 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FB, 0x200D, 0x2642⟆ 🚣🏻‍♂ E4.0 man rowing boat: light skin tone";
## 1F6A3 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🚣🏼‍♂️ E4.0 man rowing boat: medium-light skin tone # emoji-test.txt line #2245 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🚣🏼‍♂️ E4.0 man rowing boat: medium-light skin tone";
## 1F6A3 1F3FC 200D 2642                      ; minimally-qualified # 🚣🏼‍♂ E4.0 man rowing boat: medium-light skin tone # emoji-test.txt line #2246 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FC, 0x200D, 0x2642⟆ 🚣🏼‍♂ E4.0 man rowing boat: medium-light skin tone";
## 1F6A3 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🚣🏽‍♂️ E4.0 man rowing boat: medium skin tone # emoji-test.txt line #2247 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🚣🏽‍♂️ E4.0 man rowing boat: medium skin tone";
## 1F6A3 1F3FD 200D 2642                      ; minimally-qualified # 🚣🏽‍♂ E4.0 man rowing boat: medium skin tone # emoji-test.txt line #2248 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FD, 0x200D, 0x2642⟆ 🚣🏽‍♂ E4.0 man rowing boat: medium skin tone";
## 1F6A3 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🚣🏾‍♂️ E4.0 man rowing boat: medium-dark skin tone # emoji-test.txt line #2249 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🚣🏾‍♂️ E4.0 man rowing boat: medium-dark skin tone";
## 1F6A3 1F3FE 200D 2642                      ; minimally-qualified # 🚣🏾‍♂ E4.0 man rowing boat: medium-dark skin tone # emoji-test.txt line #2250 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FE, 0x200D, 0x2642⟆ 🚣🏾‍♂ E4.0 man rowing boat: medium-dark skin tone";
## 1F6A3 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🚣🏿‍♂️ E4.0 man rowing boat: dark skin tone # emoji-test.txt line #2251 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🚣🏿‍♂️ E4.0 man rowing boat: dark skin tone";
## 1F6A3 1F3FF 200D 2642                      ; minimally-qualified # 🚣🏿‍♂ E4.0 man rowing boat: dark skin tone # emoji-test.txt line #2252 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FF, 0x200D, 0x2642⟆ 🚣🏿‍♂ E4.0 man rowing boat: dark skin tone";
## 1F6A3 200D 2640 FE0F                       ; fully-qualified     # 🚣‍♀️ E4.0 woman rowing boat # emoji-test.txt line #2253 Emoji version 13.0
is Uni.new(0x1F6A3, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x200D, 0x2640, 0xFE0F⟆ 🚣‍♀️ E4.0 woman rowing boat";
## 1F6A3 200D 2640                            ; minimally-qualified # 🚣‍♀ E4.0 woman rowing boat # emoji-test.txt line #2254 Emoji version 13.0
is Uni.new(0x1F6A3, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x200D, 0x2640⟆ 🚣‍♀ E4.0 woman rowing boat";
## 1F6A3 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🚣🏻‍♀️ E4.0 woman rowing boat: light skin tone # emoji-test.txt line #2255 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🚣🏻‍♀️ E4.0 woman rowing boat: light skin tone";
## 1F6A3 1F3FB 200D 2640                      ; minimally-qualified # 🚣🏻‍♀ E4.0 woman rowing boat: light skin tone # emoji-test.txt line #2256 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FB, 0x200D, 0x2640⟆ 🚣🏻‍♀ E4.0 woman rowing boat: light skin tone";
## 1F6A3 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🚣🏼‍♀️ E4.0 woman rowing boat: medium-light skin tone # emoji-test.txt line #2257 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🚣🏼‍♀️ E4.0 woman rowing boat: medium-light skin tone";
## 1F6A3 1F3FC 200D 2640                      ; minimally-qualified # 🚣🏼‍♀ E4.0 woman rowing boat: medium-light skin tone # emoji-test.txt line #2258 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FC, 0x200D, 0x2640⟆ 🚣🏼‍♀ E4.0 woman rowing boat: medium-light skin tone";
## 1F6A3 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🚣🏽‍♀️ E4.0 woman rowing boat: medium skin tone # emoji-test.txt line #2259 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🚣🏽‍♀️ E4.0 woman rowing boat: medium skin tone";
## 1F6A3 1F3FD 200D 2640                      ; minimally-qualified # 🚣🏽‍♀ E4.0 woman rowing boat: medium skin tone # emoji-test.txt line #2260 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FD, 0x200D, 0x2640⟆ 🚣🏽‍♀ E4.0 woman rowing boat: medium skin tone";
## 1F6A3 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🚣🏾‍♀️ E4.0 woman rowing boat: medium-dark skin tone # emoji-test.txt line #2261 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🚣🏾‍♀️ E4.0 woman rowing boat: medium-dark skin tone";
## 1F6A3 1F3FE 200D 2640                      ; minimally-qualified # 🚣🏾‍♀ E4.0 woman rowing boat: medium-dark skin tone # emoji-test.txt line #2262 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FE, 0x200D, 0x2640⟆ 🚣🏾‍♀ E4.0 woman rowing boat: medium-dark skin tone";
## 1F6A3 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🚣🏿‍♀️ E4.0 woman rowing boat: dark skin tone # emoji-test.txt line #2263 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🚣🏿‍♀️ E4.0 woman rowing boat: dark skin tone";
## 1F6A3 1F3FF 200D 2640                      ; minimally-qualified # 🚣🏿‍♀ E4.0 woman rowing boat: dark skin tone # emoji-test.txt line #2264 Emoji version 13.0
is Uni.new(0x1F6A3, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6A3, 0x1F3FF, 0x200D, 0x2640⟆ 🚣🏿‍♀ E4.0 woman rowing boat: dark skin tone";
## 1F3CA 1F3FB                                ; fully-qualified     # 🏊🏻 E1.0 person swimming: light skin tone # emoji-test.txt line #2266 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FB⟆ 🏊🏻 E1.0 person swimming: light skin tone";
## 1F3CA 1F3FC                                ; fully-qualified     # 🏊🏼 E1.0 person swimming: medium-light skin tone # emoji-test.txt line #2267 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FC⟆ 🏊🏼 E1.0 person swimming: medium-light skin tone";
## 1F3CA 1F3FD                                ; fully-qualified     # 🏊🏽 E1.0 person swimming: medium skin tone # emoji-test.txt line #2268 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FD⟆ 🏊🏽 E1.0 person swimming: medium skin tone";
## 1F3CA 1F3FE                                ; fully-qualified     # 🏊🏾 E1.0 person swimming: medium-dark skin tone # emoji-test.txt line #2269 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FE⟆ 🏊🏾 E1.0 person swimming: medium-dark skin tone";
## 1F3CA 1F3FF                                ; fully-qualified     # 🏊🏿 E1.0 person swimming: dark skin tone # emoji-test.txt line #2270 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FF⟆ 🏊🏿 E1.0 person swimming: dark skin tone";
## 1F3CA 200D 2642 FE0F                       ; fully-qualified     # 🏊‍♂️ E4.0 man swimming # emoji-test.txt line #2271 Emoji version 13.0
is Uni.new(0x1F3CA, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x200D, 0x2642, 0xFE0F⟆ 🏊‍♂️ E4.0 man swimming";
## 1F3CA 200D 2642                            ; minimally-qualified # 🏊‍♂ E4.0 man swimming # emoji-test.txt line #2272 Emoji version 13.0
is Uni.new(0x1F3CA, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x200D, 0x2642⟆ 🏊‍♂ E4.0 man swimming";
## 1F3CA 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🏊🏻‍♂️ E4.0 man swimming: light skin tone # emoji-test.txt line #2273 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🏊🏻‍♂️ E4.0 man swimming: light skin tone";
## 1F3CA 1F3FB 200D 2642                      ; minimally-qualified # 🏊🏻‍♂ E4.0 man swimming: light skin tone # emoji-test.txt line #2274 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FB, 0x200D, 0x2642⟆ 🏊🏻‍♂ E4.0 man swimming: light skin tone";
## 1F3CA 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🏊🏼‍♂️ E4.0 man swimming: medium-light skin tone # emoji-test.txt line #2275 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🏊🏼‍♂️ E4.0 man swimming: medium-light skin tone";
## 1F3CA 1F3FC 200D 2642                      ; minimally-qualified # 🏊🏼‍♂ E4.0 man swimming: medium-light skin tone # emoji-test.txt line #2276 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FC, 0x200D, 0x2642⟆ 🏊🏼‍♂ E4.0 man swimming: medium-light skin tone";
## 1F3CA 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🏊🏽‍♂️ E4.0 man swimming: medium skin tone # emoji-test.txt line #2277 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🏊🏽‍♂️ E4.0 man swimming: medium skin tone";
## 1F3CA 1F3FD 200D 2642                      ; minimally-qualified # 🏊🏽‍♂ E4.0 man swimming: medium skin tone # emoji-test.txt line #2278 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FD, 0x200D, 0x2642⟆ 🏊🏽‍♂ E4.0 man swimming: medium skin tone";
## 1F3CA 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🏊🏾‍♂️ E4.0 man swimming: medium-dark skin tone # emoji-test.txt line #2279 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🏊🏾‍♂️ E4.0 man swimming: medium-dark skin tone";
## 1F3CA 1F3FE 200D 2642                      ; minimally-qualified # 🏊🏾‍♂ E4.0 man swimming: medium-dark skin tone # emoji-test.txt line #2280 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FE, 0x200D, 0x2642⟆ 🏊🏾‍♂ E4.0 man swimming: medium-dark skin tone";
## 1F3CA 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🏊🏿‍♂️ E4.0 man swimming: dark skin tone # emoji-test.txt line #2281 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🏊🏿‍♂️ E4.0 man swimming: dark skin tone";
## 1F3CA 1F3FF 200D 2642                      ; minimally-qualified # 🏊🏿‍♂ E4.0 man swimming: dark skin tone # emoji-test.txt line #2282 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FF, 0x200D, 0x2642⟆ 🏊🏿‍♂ E4.0 man swimming: dark skin tone";
## 1F3CA 200D 2640 FE0F                       ; fully-qualified     # 🏊‍♀️ E4.0 woman swimming # emoji-test.txt line #2283 Emoji version 13.0
is Uni.new(0x1F3CA, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x200D, 0x2640, 0xFE0F⟆ 🏊‍♀️ E4.0 woman swimming";
## 1F3CA 200D 2640                            ; minimally-qualified # 🏊‍♀ E4.0 woman swimming # emoji-test.txt line #2284 Emoji version 13.0
is Uni.new(0x1F3CA, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x200D, 0x2640⟆ 🏊‍♀ E4.0 woman swimming";
## 1F3CA 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🏊🏻‍♀️ E4.0 woman swimming: light skin tone # emoji-test.txt line #2285 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🏊🏻‍♀️ E4.0 woman swimming: light skin tone";
## 1F3CA 1F3FB 200D 2640                      ; minimally-qualified # 🏊🏻‍♀ E4.0 woman swimming: light skin tone # emoji-test.txt line #2286 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FB, 0x200D, 0x2640⟆ 🏊🏻‍♀ E4.0 woman swimming: light skin tone";
## 1F3CA 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🏊🏼‍♀️ E4.0 woman swimming: medium-light skin tone # emoji-test.txt line #2287 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🏊🏼‍♀️ E4.0 woman swimming: medium-light skin tone";
## 1F3CA 1F3FC 200D 2640                      ; minimally-qualified # 🏊🏼‍♀ E4.0 woman swimming: medium-light skin tone # emoji-test.txt line #2288 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FC, 0x200D, 0x2640⟆ 🏊🏼‍♀ E4.0 woman swimming: medium-light skin tone";
## 1F3CA 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🏊🏽‍♀️ E4.0 woman swimming: medium skin tone # emoji-test.txt line #2289 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🏊🏽‍♀️ E4.0 woman swimming: medium skin tone";
## 1F3CA 1F3FD 200D 2640                      ; minimally-qualified # 🏊🏽‍♀ E4.0 woman swimming: medium skin tone # emoji-test.txt line #2290 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FD, 0x200D, 0x2640⟆ 🏊🏽‍♀ E4.0 woman swimming: medium skin tone";
## 1F3CA 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🏊🏾‍♀️ E4.0 woman swimming: medium-dark skin tone # emoji-test.txt line #2291 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🏊🏾‍♀️ E4.0 woman swimming: medium-dark skin tone";
## 1F3CA 1F3FE 200D 2640                      ; minimally-qualified # 🏊🏾‍♀ E4.0 woman swimming: medium-dark skin tone # emoji-test.txt line #2292 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FE, 0x200D, 0x2640⟆ 🏊🏾‍♀ E4.0 woman swimming: medium-dark skin tone";
## 1F3CA 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🏊🏿‍♀️ E4.0 woman swimming: dark skin tone # emoji-test.txt line #2293 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🏊🏿‍♀️ E4.0 woman swimming: dark skin tone";
## 1F3CA 1F3FF 200D 2640                      ; minimally-qualified # 🏊🏿‍♀ E4.0 woman swimming: dark skin tone # emoji-test.txt line #2294 Emoji version 13.0
is Uni.new(0x1F3CA, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CA, 0x1F3FF, 0x200D, 0x2640⟆ 🏊🏿‍♀ E4.0 woman swimming: dark skin tone";
## 26F9 FE0F                                  ; fully-qualified     # ⛹️ E0.7 person bouncing ball # emoji-test.txt line #2295 Emoji version 13.0
is Uni.new(0x26F9, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0xFE0F⟆ ⛹️ E0.7 person bouncing ball";
## 26F9 1F3FB                                 ; fully-qualified     # ⛹🏻 E2.0 person bouncing ball: light skin tone # emoji-test.txt line #2297 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FB⟆ ⛹🏻 E2.0 person bouncing ball: light skin tone";
## 26F9 1F3FC                                 ; fully-qualified     # ⛹🏼 E2.0 person bouncing ball: medium-light skin tone # emoji-test.txt line #2298 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FC⟆ ⛹🏼 E2.0 person bouncing ball: medium-light skin tone";
## 26F9 1F3FD                                 ; fully-qualified     # ⛹🏽 E2.0 person bouncing ball: medium skin tone # emoji-test.txt line #2299 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FD⟆ ⛹🏽 E2.0 person bouncing ball: medium skin tone";
## 26F9 1F3FE                                 ; fully-qualified     # ⛹🏾 E2.0 person bouncing ball: medium-dark skin tone # emoji-test.txt line #2300 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FE⟆ ⛹🏾 E2.0 person bouncing ball: medium-dark skin tone";
## 26F9 1F3FF                                 ; fully-qualified     # ⛹🏿 E2.0 person bouncing ball: dark skin tone # emoji-test.txt line #2301 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FF⟆ ⛹🏿 E2.0 person bouncing ball: dark skin tone";
## 26F9 FE0F 200D 2642 FE0F                   ; fully-qualified     # ⛹️‍♂️ E4.0 man bouncing ball # emoji-test.txt line #2302 Emoji version 13.0
is Uni.new(0x26F9, 0xFE0F, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0xFE0F, 0x200D, 0x2642, 0xFE0F⟆ ⛹️‍♂️ E4.0 man bouncing ball";
## 26F9 200D 2642 FE0F                        ; unqualified         # ⛹‍♂️ E4.0 man bouncing ball # emoji-test.txt line #2303 Emoji version 13.0
is Uni.new(0x26F9, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x200D, 0x2642, 0xFE0F⟆ ⛹‍♂️ E4.0 man bouncing ball";
## 26F9 FE0F 200D 2642                        ; unqualified         # ⛹️‍♂ E4.0 man bouncing ball # emoji-test.txt line #2304 Emoji version 13.0
is Uni.new(0x26F9, 0xFE0F, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x26F9, 0xFE0F, 0x200D, 0x2642⟆ ⛹️‍♂ E4.0 man bouncing ball";
## 26F9 200D 2642                             ; unqualified         # ⛹‍♂ E4.0 man bouncing ball # emoji-test.txt line #2305 Emoji version 13.0
is Uni.new(0x26F9, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x26F9, 0x200D, 0x2642⟆ ⛹‍♂ E4.0 man bouncing ball";
## 26F9 1F3FB 200D 2642 FE0F                  ; fully-qualified     # ⛹🏻‍♂️ E4.0 man bouncing ball: light skin tone # emoji-test.txt line #2306 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ ⛹🏻‍♂️ E4.0 man bouncing ball: light skin tone";
## 26F9 1F3FB 200D 2642                       ; minimally-qualified # ⛹🏻‍♂ E4.0 man bouncing ball: light skin tone # emoji-test.txt line #2307 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FB, 0x200D, 0x2642⟆ ⛹🏻‍♂ E4.0 man bouncing ball: light skin tone";
## 26F9 1F3FC 200D 2642 FE0F                  ; fully-qualified     # ⛹🏼‍♂️ E4.0 man bouncing ball: medium-light skin tone # emoji-test.txt line #2308 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ ⛹🏼‍♂️ E4.0 man bouncing ball: medium-light skin tone";
## 26F9 1F3FC 200D 2642                       ; minimally-qualified # ⛹🏼‍♂ E4.0 man bouncing ball: medium-light skin tone # emoji-test.txt line #2309 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FC, 0x200D, 0x2642⟆ ⛹🏼‍♂ E4.0 man bouncing ball: medium-light skin tone";
## 26F9 1F3FD 200D 2642 FE0F                  ; fully-qualified     # ⛹🏽‍♂️ E4.0 man bouncing ball: medium skin tone # emoji-test.txt line #2310 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ ⛹🏽‍♂️ E4.0 man bouncing ball: medium skin tone";
## 26F9 1F3FD 200D 2642                       ; minimally-qualified # ⛹🏽‍♂ E4.0 man bouncing ball: medium skin tone # emoji-test.txt line #2311 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FD, 0x200D, 0x2642⟆ ⛹🏽‍♂ E4.0 man bouncing ball: medium skin tone";
## 26F9 1F3FE 200D 2642 FE0F                  ; fully-qualified     # ⛹🏾‍♂️ E4.0 man bouncing ball: medium-dark skin tone # emoji-test.txt line #2312 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ ⛹🏾‍♂️ E4.0 man bouncing ball: medium-dark skin tone";
## 26F9 1F3FE 200D 2642                       ; minimally-qualified # ⛹🏾‍♂ E4.0 man bouncing ball: medium-dark skin tone # emoji-test.txt line #2313 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FE, 0x200D, 0x2642⟆ ⛹🏾‍♂ E4.0 man bouncing ball: medium-dark skin tone";
## 26F9 1F3FF 200D 2642 FE0F                  ; fully-qualified     # ⛹🏿‍♂️ E4.0 man bouncing ball: dark skin tone # emoji-test.txt line #2314 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ ⛹🏿‍♂️ E4.0 man bouncing ball: dark skin tone";
## 26F9 1F3FF 200D 2642                       ; minimally-qualified # ⛹🏿‍♂ E4.0 man bouncing ball: dark skin tone # emoji-test.txt line #2315 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FF, 0x200D, 0x2642⟆ ⛹🏿‍♂ E4.0 man bouncing ball: dark skin tone";
## 26F9 FE0F 200D 2640 FE0F                   ; fully-qualified     # ⛹️‍♀️ E4.0 woman bouncing ball # emoji-test.txt line #2316 Emoji version 13.0
is Uni.new(0x26F9, 0xFE0F, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0xFE0F, 0x200D, 0x2640, 0xFE0F⟆ ⛹️‍♀️ E4.0 woman bouncing ball";
## 26F9 200D 2640 FE0F                        ; unqualified         # ⛹‍♀️ E4.0 woman bouncing ball # emoji-test.txt line #2317 Emoji version 13.0
is Uni.new(0x26F9, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x200D, 0x2640, 0xFE0F⟆ ⛹‍♀️ E4.0 woman bouncing ball";
## 26F9 FE0F 200D 2640                        ; unqualified         # ⛹️‍♀ E4.0 woman bouncing ball # emoji-test.txt line #2318 Emoji version 13.0
is Uni.new(0x26F9, 0xFE0F, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x26F9, 0xFE0F, 0x200D, 0x2640⟆ ⛹️‍♀ E4.0 woman bouncing ball";
## 26F9 200D 2640                             ; unqualified         # ⛹‍♀ E4.0 woman bouncing ball # emoji-test.txt line #2319 Emoji version 13.0
is Uni.new(0x26F9, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x26F9, 0x200D, 0x2640⟆ ⛹‍♀ E4.0 woman bouncing ball";
## 26F9 1F3FB 200D 2640 FE0F                  ; fully-qualified     # ⛹🏻‍♀️ E4.0 woman bouncing ball: light skin tone # emoji-test.txt line #2320 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ ⛹🏻‍♀️ E4.0 woman bouncing ball: light skin tone";
## 26F9 1F3FB 200D 2640                       ; minimally-qualified # ⛹🏻‍♀ E4.0 woman bouncing ball: light skin tone # emoji-test.txt line #2321 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FB, 0x200D, 0x2640⟆ ⛹🏻‍♀ E4.0 woman bouncing ball: light skin tone";
## 26F9 1F3FC 200D 2640 FE0F                  ; fully-qualified     # ⛹🏼‍♀️ E4.0 woman bouncing ball: medium-light skin tone # emoji-test.txt line #2322 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ ⛹🏼‍♀️ E4.0 woman bouncing ball: medium-light skin tone";
## 26F9 1F3FC 200D 2640                       ; minimally-qualified # ⛹🏼‍♀ E4.0 woman bouncing ball: medium-light skin tone # emoji-test.txt line #2323 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FC, 0x200D, 0x2640⟆ ⛹🏼‍♀ E4.0 woman bouncing ball: medium-light skin tone";
## 26F9 1F3FD 200D 2640 FE0F                  ; fully-qualified     # ⛹🏽‍♀️ E4.0 woman bouncing ball: medium skin tone # emoji-test.txt line #2324 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ ⛹🏽‍♀️ E4.0 woman bouncing ball: medium skin tone";
## 26F9 1F3FD 200D 2640                       ; minimally-qualified # ⛹🏽‍♀ E4.0 woman bouncing ball: medium skin tone # emoji-test.txt line #2325 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FD, 0x200D, 0x2640⟆ ⛹🏽‍♀ E4.0 woman bouncing ball: medium skin tone";
## 26F9 1F3FE 200D 2640 FE0F                  ; fully-qualified     # ⛹🏾‍♀️ E4.0 woman bouncing ball: medium-dark skin tone # emoji-test.txt line #2326 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ ⛹🏾‍♀️ E4.0 woman bouncing ball: medium-dark skin tone";
## 26F9 1F3FE 200D 2640                       ; minimally-qualified # ⛹🏾‍♀ E4.0 woman bouncing ball: medium-dark skin tone # emoji-test.txt line #2327 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FE, 0x200D, 0x2640⟆ ⛹🏾‍♀ E4.0 woman bouncing ball: medium-dark skin tone";
## 26F9 1F3FF 200D 2640 FE0F                  ; fully-qualified     # ⛹🏿‍♀️ E4.0 woman bouncing ball: dark skin tone # emoji-test.txt line #2328 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ ⛹🏿‍♀️ E4.0 woman bouncing ball: dark skin tone";
## 26F9 1F3FF 200D 2640                       ; minimally-qualified # ⛹🏿‍♀ E4.0 woman bouncing ball: dark skin tone # emoji-test.txt line #2329 Emoji version 13.0
is Uni.new(0x26F9, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x26F9, 0x1F3FF, 0x200D, 0x2640⟆ ⛹🏿‍♀ E4.0 woman bouncing ball: dark skin tone";
## 1F3CB FE0F                                 ; fully-qualified     # 🏋️ E0.7 person lifting weights # emoji-test.txt line #2330 Emoji version 13.0
is Uni.new(0x1F3CB, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0xFE0F⟆ 🏋️ E0.7 person lifting weights";
## 1F3CB 1F3FB                                ; fully-qualified     # 🏋🏻 E2.0 person lifting weights: light skin tone # emoji-test.txt line #2332 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FB⟆ 🏋🏻 E2.0 person lifting weights: light skin tone";
## 1F3CB 1F3FC                                ; fully-qualified     # 🏋🏼 E2.0 person lifting weights: medium-light skin tone # emoji-test.txt line #2333 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FC⟆ 🏋🏼 E2.0 person lifting weights: medium-light skin tone";
## 1F3CB 1F3FD                                ; fully-qualified     # 🏋🏽 E2.0 person lifting weights: medium skin tone # emoji-test.txt line #2334 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FD⟆ 🏋🏽 E2.0 person lifting weights: medium skin tone";
## 1F3CB 1F3FE                                ; fully-qualified     # 🏋🏾 E2.0 person lifting weights: medium-dark skin tone # emoji-test.txt line #2335 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FE⟆ 🏋🏾 E2.0 person lifting weights: medium-dark skin tone";
## 1F3CB 1F3FF                                ; fully-qualified     # 🏋🏿 E2.0 person lifting weights: dark skin tone # emoji-test.txt line #2336 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FF⟆ 🏋🏿 E2.0 person lifting weights: dark skin tone";
## 1F3CB FE0F 200D 2642 FE0F                  ; fully-qualified     # 🏋️‍♂️ E4.0 man lifting weights # emoji-test.txt line #2337 Emoji version 13.0
is Uni.new(0x1F3CB, 0xFE0F, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0xFE0F, 0x200D, 0x2642, 0xFE0F⟆ 🏋️‍♂️ E4.0 man lifting weights";
## 1F3CB 200D 2642 FE0F                       ; unqualified         # 🏋‍♂️ E4.0 man lifting weights # emoji-test.txt line #2338 Emoji version 13.0
is Uni.new(0x1F3CB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x200D, 0x2642, 0xFE0F⟆ 🏋‍♂️ E4.0 man lifting weights";
## 1F3CB FE0F 200D 2642                       ; unqualified         # 🏋️‍♂ E4.0 man lifting weights # emoji-test.txt line #2339 Emoji version 13.0
is Uni.new(0x1F3CB, 0xFE0F, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CB, 0xFE0F, 0x200D, 0x2642⟆ 🏋️‍♂ E4.0 man lifting weights";
## 1F3CB 200D 2642                            ; unqualified         # 🏋‍♂ E4.0 man lifting weights # emoji-test.txt line #2340 Emoji version 13.0
is Uni.new(0x1F3CB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x200D, 0x2642⟆ 🏋‍♂ E4.0 man lifting weights";
## 1F3CB 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🏋🏻‍♂️ E4.0 man lifting weights: light skin tone # emoji-test.txt line #2341 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🏋🏻‍♂️ E4.0 man lifting weights: light skin tone";
## 1F3CB 1F3FB 200D 2642                      ; minimally-qualified # 🏋🏻‍♂ E4.0 man lifting weights: light skin tone # emoji-test.txt line #2342 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FB, 0x200D, 0x2642⟆ 🏋🏻‍♂ E4.0 man lifting weights: light skin tone";
## 1F3CB 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🏋🏼‍♂️ E4.0 man lifting weights: medium-light skin tone # emoji-test.txt line #2343 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🏋🏼‍♂️ E4.0 man lifting weights: medium-light skin tone";
## 1F3CB 1F3FC 200D 2642                      ; minimally-qualified # 🏋🏼‍♂ E4.0 man lifting weights: medium-light skin tone # emoji-test.txt line #2344 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FC, 0x200D, 0x2642⟆ 🏋🏼‍♂ E4.0 man lifting weights: medium-light skin tone";
## 1F3CB 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🏋🏽‍♂️ E4.0 man lifting weights: medium skin tone # emoji-test.txt line #2345 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🏋🏽‍♂️ E4.0 man lifting weights: medium skin tone";
## 1F3CB 1F3FD 200D 2642                      ; minimally-qualified # 🏋🏽‍♂ E4.0 man lifting weights: medium skin tone # emoji-test.txt line #2346 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FD, 0x200D, 0x2642⟆ 🏋🏽‍♂ E4.0 man lifting weights: medium skin tone";
## 1F3CB 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🏋🏾‍♂️ E4.0 man lifting weights: medium-dark skin tone # emoji-test.txt line #2347 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🏋🏾‍♂️ E4.0 man lifting weights: medium-dark skin tone";
## 1F3CB 1F3FE 200D 2642                      ; minimally-qualified # 🏋🏾‍♂ E4.0 man lifting weights: medium-dark skin tone # emoji-test.txt line #2348 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FE, 0x200D, 0x2642⟆ 🏋🏾‍♂ E4.0 man lifting weights: medium-dark skin tone";
## 1F3CB 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🏋🏿‍♂️ E4.0 man lifting weights: dark skin tone # emoji-test.txt line #2349 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🏋🏿‍♂️ E4.0 man lifting weights: dark skin tone";
## 1F3CB 1F3FF 200D 2642                      ; minimally-qualified # 🏋🏿‍♂ E4.0 man lifting weights: dark skin tone # emoji-test.txt line #2350 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FF, 0x200D, 0x2642⟆ 🏋🏿‍♂ E4.0 man lifting weights: dark skin tone";
## 1F3CB FE0F 200D 2640 FE0F                  ; fully-qualified     # 🏋️‍♀️ E4.0 woman lifting weights # emoji-test.txt line #2351 Emoji version 13.0
is Uni.new(0x1F3CB, 0xFE0F, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0xFE0F, 0x200D, 0x2640, 0xFE0F⟆ 🏋️‍♀️ E4.0 woman lifting weights";
## 1F3CB 200D 2640 FE0F                       ; unqualified         # 🏋‍♀️ E4.0 woman lifting weights # emoji-test.txt line #2352 Emoji version 13.0
is Uni.new(0x1F3CB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x200D, 0x2640, 0xFE0F⟆ 🏋‍♀️ E4.0 woman lifting weights";
## 1F3CB FE0F 200D 2640                       ; unqualified         # 🏋️‍♀ E4.0 woman lifting weights # emoji-test.txt line #2353 Emoji version 13.0
is Uni.new(0x1F3CB, 0xFE0F, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CB, 0xFE0F, 0x200D, 0x2640⟆ 🏋️‍♀ E4.0 woman lifting weights";
## 1F3CB 200D 2640                            ; unqualified         # 🏋‍♀ E4.0 woman lifting weights # emoji-test.txt line #2354 Emoji version 13.0
is Uni.new(0x1F3CB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x200D, 0x2640⟆ 🏋‍♀ E4.0 woman lifting weights";
## 1F3CB 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🏋🏻‍♀️ E4.0 woman lifting weights: light skin tone # emoji-test.txt line #2355 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🏋🏻‍♀️ E4.0 woman lifting weights: light skin tone";
## 1F3CB 1F3FB 200D 2640                      ; minimally-qualified # 🏋🏻‍♀ E4.0 woman lifting weights: light skin tone # emoji-test.txt line #2356 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FB, 0x200D, 0x2640⟆ 🏋🏻‍♀ E4.0 woman lifting weights: light skin tone";
## 1F3CB 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🏋🏼‍♀️ E4.0 woman lifting weights: medium-light skin tone # emoji-test.txt line #2357 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🏋🏼‍♀️ E4.0 woman lifting weights: medium-light skin tone";
## 1F3CB 1F3FC 200D 2640                      ; minimally-qualified # 🏋🏼‍♀ E4.0 woman lifting weights: medium-light skin tone # emoji-test.txt line #2358 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FC, 0x200D, 0x2640⟆ 🏋🏼‍♀ E4.0 woman lifting weights: medium-light skin tone";
## 1F3CB 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🏋🏽‍♀️ E4.0 woman lifting weights: medium skin tone # emoji-test.txt line #2359 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🏋🏽‍♀️ E4.0 woman lifting weights: medium skin tone";
## 1F3CB 1F3FD 200D 2640                      ; minimally-qualified # 🏋🏽‍♀ E4.0 woman lifting weights: medium skin tone # emoji-test.txt line #2360 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FD, 0x200D, 0x2640⟆ 🏋🏽‍♀ E4.0 woman lifting weights: medium skin tone";
## 1F3CB 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🏋🏾‍♀️ E4.0 woman lifting weights: medium-dark skin tone # emoji-test.txt line #2361 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🏋🏾‍♀️ E4.0 woman lifting weights: medium-dark skin tone";
## 1F3CB 1F3FE 200D 2640                      ; minimally-qualified # 🏋🏾‍♀ E4.0 woman lifting weights: medium-dark skin tone # emoji-test.txt line #2362 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FE, 0x200D, 0x2640⟆ 🏋🏾‍♀ E4.0 woman lifting weights: medium-dark skin tone";
## 1F3CB 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🏋🏿‍♀️ E4.0 woman lifting weights: dark skin tone # emoji-test.txt line #2363 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🏋🏿‍♀️ E4.0 woman lifting weights: dark skin tone";
## 1F3CB 1F3FF 200D 2640                      ; minimally-qualified # 🏋🏿‍♀ E4.0 woman lifting weights: dark skin tone # emoji-test.txt line #2364 Emoji version 13.0
is Uni.new(0x1F3CB, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F3CB, 0x1F3FF, 0x200D, 0x2640⟆ 🏋🏿‍♀ E4.0 woman lifting weights: dark skin tone";
## 1F6B4 1F3FB                                ; fully-qualified     # 🚴🏻 E1.0 person biking: light skin tone # emoji-test.txt line #2366 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FB⟆ 🚴🏻 E1.0 person biking: light skin tone";
## 1F6B4 1F3FC                                ; fully-qualified     # 🚴🏼 E1.0 person biking: medium-light skin tone # emoji-test.txt line #2367 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FC⟆ 🚴🏼 E1.0 person biking: medium-light skin tone";
## 1F6B4 1F3FD                                ; fully-qualified     # 🚴🏽 E1.0 person biking: medium skin tone # emoji-test.txt line #2368 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FD⟆ 🚴🏽 E1.0 person biking: medium skin tone";
## 1F6B4 1F3FE                                ; fully-qualified     # 🚴🏾 E1.0 person biking: medium-dark skin tone # emoji-test.txt line #2369 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FE⟆ 🚴🏾 E1.0 person biking: medium-dark skin tone";
## 1F6B4 1F3FF                                ; fully-qualified     # 🚴🏿 E1.0 person biking: dark skin tone # emoji-test.txt line #2370 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FF⟆ 🚴🏿 E1.0 person biking: dark skin tone";
## 1F6B4 200D 2642 FE0F                       ; fully-qualified     # 🚴‍♂️ E4.0 man biking # emoji-test.txt line #2371 Emoji version 13.0
is Uni.new(0x1F6B4, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x200D, 0x2642, 0xFE0F⟆ 🚴‍♂️ E4.0 man biking";
## 1F6B4 200D 2642                            ; minimally-qualified # 🚴‍♂ E4.0 man biking # emoji-test.txt line #2372 Emoji version 13.0
is Uni.new(0x1F6B4, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x200D, 0x2642⟆ 🚴‍♂ E4.0 man biking";
## 1F6B4 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🚴🏻‍♂️ E4.0 man biking: light skin tone # emoji-test.txt line #2373 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🚴🏻‍♂️ E4.0 man biking: light skin tone";
## 1F6B4 1F3FB 200D 2642                      ; minimally-qualified # 🚴🏻‍♂ E4.0 man biking: light skin tone # emoji-test.txt line #2374 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FB, 0x200D, 0x2642⟆ 🚴🏻‍♂ E4.0 man biking: light skin tone";
## 1F6B4 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🚴🏼‍♂️ E4.0 man biking: medium-light skin tone # emoji-test.txt line #2375 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🚴🏼‍♂️ E4.0 man biking: medium-light skin tone";
## 1F6B4 1F3FC 200D 2642                      ; minimally-qualified # 🚴🏼‍♂ E4.0 man biking: medium-light skin tone # emoji-test.txt line #2376 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FC, 0x200D, 0x2642⟆ 🚴🏼‍♂ E4.0 man biking: medium-light skin tone";
## 1F6B4 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🚴🏽‍♂️ E4.0 man biking: medium skin tone # emoji-test.txt line #2377 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🚴🏽‍♂️ E4.0 man biking: medium skin tone";
## 1F6B4 1F3FD 200D 2642                      ; minimally-qualified # 🚴🏽‍♂ E4.0 man biking: medium skin tone # emoji-test.txt line #2378 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FD, 0x200D, 0x2642⟆ 🚴🏽‍♂ E4.0 man biking: medium skin tone";
## 1F6B4 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🚴🏾‍♂️ E4.0 man biking: medium-dark skin tone # emoji-test.txt line #2379 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🚴🏾‍♂️ E4.0 man biking: medium-dark skin tone";
## 1F6B4 1F3FE 200D 2642                      ; minimally-qualified # 🚴🏾‍♂ E4.0 man biking: medium-dark skin tone # emoji-test.txt line #2380 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FE, 0x200D, 0x2642⟆ 🚴🏾‍♂ E4.0 man biking: medium-dark skin tone";
## 1F6B4 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🚴🏿‍♂️ E4.0 man biking: dark skin tone # emoji-test.txt line #2381 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🚴🏿‍♂️ E4.0 man biking: dark skin tone";
## 1F6B4 1F3FF 200D 2642                      ; minimally-qualified # 🚴🏿‍♂ E4.0 man biking: dark skin tone # emoji-test.txt line #2382 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FF, 0x200D, 0x2642⟆ 🚴🏿‍♂ E4.0 man biking: dark skin tone";
## 1F6B4 200D 2640 FE0F                       ; fully-qualified     # 🚴‍♀️ E4.0 woman biking # emoji-test.txt line #2383 Emoji version 13.0
is Uni.new(0x1F6B4, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x200D, 0x2640, 0xFE0F⟆ 🚴‍♀️ E4.0 woman biking";
## 1F6B4 200D 2640                            ; minimally-qualified # 🚴‍♀ E4.0 woman biking # emoji-test.txt line #2384 Emoji version 13.0
is Uni.new(0x1F6B4, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x200D, 0x2640⟆ 🚴‍♀ E4.0 woman biking";
## 1F6B4 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🚴🏻‍♀️ E4.0 woman biking: light skin tone # emoji-test.txt line #2385 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🚴🏻‍♀️ E4.0 woman biking: light skin tone";
## 1F6B4 1F3FB 200D 2640                      ; minimally-qualified # 🚴🏻‍♀ E4.0 woman biking: light skin tone # emoji-test.txt line #2386 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FB, 0x200D, 0x2640⟆ 🚴🏻‍♀ E4.0 woman biking: light skin tone";
## 1F6B4 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🚴🏼‍♀️ E4.0 woman biking: medium-light skin tone # emoji-test.txt line #2387 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🚴🏼‍♀️ E4.0 woman biking: medium-light skin tone";
## 1F6B4 1F3FC 200D 2640                      ; minimally-qualified # 🚴🏼‍♀ E4.0 woman biking: medium-light skin tone # emoji-test.txt line #2388 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FC, 0x200D, 0x2640⟆ 🚴🏼‍♀ E4.0 woman biking: medium-light skin tone";
## 1F6B4 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🚴🏽‍♀️ E4.0 woman biking: medium skin tone # emoji-test.txt line #2389 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🚴🏽‍♀️ E4.0 woman biking: medium skin tone";
## 1F6B4 1F3FD 200D 2640                      ; minimally-qualified # 🚴🏽‍♀ E4.0 woman biking: medium skin tone # emoji-test.txt line #2390 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FD, 0x200D, 0x2640⟆ 🚴🏽‍♀ E4.0 woman biking: medium skin tone";
## 1F6B4 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🚴🏾‍♀️ E4.0 woman biking: medium-dark skin tone # emoji-test.txt line #2391 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🚴🏾‍♀️ E4.0 woman biking: medium-dark skin tone";
## 1F6B4 1F3FE 200D 2640                      ; minimally-qualified # 🚴🏾‍♀ E4.0 woman biking: medium-dark skin tone # emoji-test.txt line #2392 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FE, 0x200D, 0x2640⟆ 🚴🏾‍♀ E4.0 woman biking: medium-dark skin tone";
## 1F6B4 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🚴🏿‍♀️ E4.0 woman biking: dark skin tone # emoji-test.txt line #2393 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🚴🏿‍♀️ E4.0 woman biking: dark skin tone";
## 1F6B4 1F3FF 200D 2640                      ; minimally-qualified # 🚴🏿‍♀ E4.0 woman biking: dark skin tone # emoji-test.txt line #2394 Emoji version 13.0
is Uni.new(0x1F6B4, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B4, 0x1F3FF, 0x200D, 0x2640⟆ 🚴🏿‍♀ E4.0 woman biking: dark skin tone";
## 1F6B5 1F3FB                                ; fully-qualified     # 🚵🏻 E1.0 person mountain biking: light skin tone # emoji-test.txt line #2396 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FB⟆ 🚵🏻 E1.0 person mountain biking: light skin tone";
## 1F6B5 1F3FC                                ; fully-qualified     # 🚵🏼 E1.0 person mountain biking: medium-light skin tone # emoji-test.txt line #2397 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FC⟆ 🚵🏼 E1.0 person mountain biking: medium-light skin tone";
## 1F6B5 1F3FD                                ; fully-qualified     # 🚵🏽 E1.0 person mountain biking: medium skin tone # emoji-test.txt line #2398 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FD⟆ 🚵🏽 E1.0 person mountain biking: medium skin tone";
## 1F6B5 1F3FE                                ; fully-qualified     # 🚵🏾 E1.0 person mountain biking: medium-dark skin tone # emoji-test.txt line #2399 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FE⟆ 🚵🏾 E1.0 person mountain biking: medium-dark skin tone";
## 1F6B5 1F3FF                                ; fully-qualified     # 🚵🏿 E1.0 person mountain biking: dark skin tone # emoji-test.txt line #2400 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FF⟆ 🚵🏿 E1.0 person mountain biking: dark skin tone";
## 1F6B5 200D 2642 FE0F                       ; fully-qualified     # 🚵‍♂️ E4.0 man mountain biking # emoji-test.txt line #2401 Emoji version 13.0
is Uni.new(0x1F6B5, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x200D, 0x2642, 0xFE0F⟆ 🚵‍♂️ E4.0 man mountain biking";
## 1F6B5 200D 2642                            ; minimally-qualified # 🚵‍♂ E4.0 man mountain biking # emoji-test.txt line #2402 Emoji version 13.0
is Uni.new(0x1F6B5, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x200D, 0x2642⟆ 🚵‍♂ E4.0 man mountain biking";
## 1F6B5 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🚵🏻‍♂️ E4.0 man mountain biking: light skin tone # emoji-test.txt line #2403 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🚵🏻‍♂️ E4.0 man mountain biking: light skin tone";
## 1F6B5 1F3FB 200D 2642                      ; minimally-qualified # 🚵🏻‍♂ E4.0 man mountain biking: light skin tone # emoji-test.txt line #2404 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FB, 0x200D, 0x2642⟆ 🚵🏻‍♂ E4.0 man mountain biking: light skin tone";
## 1F6B5 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🚵🏼‍♂️ E4.0 man mountain biking: medium-light skin tone # emoji-test.txt line #2405 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🚵🏼‍♂️ E4.0 man mountain biking: medium-light skin tone";
## 1F6B5 1F3FC 200D 2642                      ; minimally-qualified # 🚵🏼‍♂ E4.0 man mountain biking: medium-light skin tone # emoji-test.txt line #2406 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FC, 0x200D, 0x2642⟆ 🚵🏼‍♂ E4.0 man mountain biking: medium-light skin tone";
## 1F6B5 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🚵🏽‍♂️ E4.0 man mountain biking: medium skin tone # emoji-test.txt line #2407 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🚵🏽‍♂️ E4.0 man mountain biking: medium skin tone";
## 1F6B5 1F3FD 200D 2642                      ; minimally-qualified # 🚵🏽‍♂ E4.0 man mountain biking: medium skin tone # emoji-test.txt line #2408 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FD, 0x200D, 0x2642⟆ 🚵🏽‍♂ E4.0 man mountain biking: medium skin tone";
## 1F6B5 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🚵🏾‍♂️ E4.0 man mountain biking: medium-dark skin tone # emoji-test.txt line #2409 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🚵🏾‍♂️ E4.0 man mountain biking: medium-dark skin tone";
## 1F6B5 1F3FE 200D 2642                      ; minimally-qualified # 🚵🏾‍♂ E4.0 man mountain biking: medium-dark skin tone # emoji-test.txt line #2410 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FE, 0x200D, 0x2642⟆ 🚵🏾‍♂ E4.0 man mountain biking: medium-dark skin tone";
## 1F6B5 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🚵🏿‍♂️ E4.0 man mountain biking: dark skin tone # emoji-test.txt line #2411 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🚵🏿‍♂️ E4.0 man mountain biking: dark skin tone";
## 1F6B5 1F3FF 200D 2642                      ; minimally-qualified # 🚵🏿‍♂ E4.0 man mountain biking: dark skin tone # emoji-test.txt line #2412 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FF, 0x200D, 0x2642⟆ 🚵🏿‍♂ E4.0 man mountain biking: dark skin tone";
## 1F6B5 200D 2640 FE0F                       ; fully-qualified     # 🚵‍♀️ E4.0 woman mountain biking # emoji-test.txt line #2413 Emoji version 13.0
is Uni.new(0x1F6B5, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x200D, 0x2640, 0xFE0F⟆ 🚵‍♀️ E4.0 woman mountain biking";
## 1F6B5 200D 2640                            ; minimally-qualified # 🚵‍♀ E4.0 woman mountain biking # emoji-test.txt line #2414 Emoji version 13.0
is Uni.new(0x1F6B5, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x200D, 0x2640⟆ 🚵‍♀ E4.0 woman mountain biking";
## 1F6B5 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🚵🏻‍♀️ E4.0 woman mountain biking: light skin tone # emoji-test.txt line #2415 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🚵🏻‍♀️ E4.0 woman mountain biking: light skin tone";
## 1F6B5 1F3FB 200D 2640                      ; minimally-qualified # 🚵🏻‍♀ E4.0 woman mountain biking: light skin tone # emoji-test.txt line #2416 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FB, 0x200D, 0x2640⟆ 🚵🏻‍♀ E4.0 woman mountain biking: light skin tone";
## 1F6B5 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🚵🏼‍♀️ E4.0 woman mountain biking: medium-light skin tone # emoji-test.txt line #2417 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🚵🏼‍♀️ E4.0 woman mountain biking: medium-light skin tone";
## 1F6B5 1F3FC 200D 2640                      ; minimally-qualified # 🚵🏼‍♀ E4.0 woman mountain biking: medium-light skin tone # emoji-test.txt line #2418 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FC, 0x200D, 0x2640⟆ 🚵🏼‍♀ E4.0 woman mountain biking: medium-light skin tone";
## 1F6B5 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🚵🏽‍♀️ E4.0 woman mountain biking: medium skin tone # emoji-test.txt line #2419 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🚵🏽‍♀️ E4.0 woman mountain biking: medium skin tone";
## 1F6B5 1F3FD 200D 2640                      ; minimally-qualified # 🚵🏽‍♀ E4.0 woman mountain biking: medium skin tone # emoji-test.txt line #2420 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FD, 0x200D, 0x2640⟆ 🚵🏽‍♀ E4.0 woman mountain biking: medium skin tone";
## 1F6B5 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🚵🏾‍♀️ E4.0 woman mountain biking: medium-dark skin tone # emoji-test.txt line #2421 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🚵🏾‍♀️ E4.0 woman mountain biking: medium-dark skin tone";
## 1F6B5 1F3FE 200D 2640                      ; minimally-qualified # 🚵🏾‍♀ E4.0 woman mountain biking: medium-dark skin tone # emoji-test.txt line #2422 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FE, 0x200D, 0x2640⟆ 🚵🏾‍♀ E4.0 woman mountain biking: medium-dark skin tone";
## 1F6B5 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🚵🏿‍♀️ E4.0 woman mountain biking: dark skin tone # emoji-test.txt line #2423 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🚵🏿‍♀️ E4.0 woman mountain biking: dark skin tone";
## 1F6B5 1F3FF 200D 2640                      ; minimally-qualified # 🚵🏿‍♀ E4.0 woman mountain biking: dark skin tone # emoji-test.txt line #2424 Emoji version 13.0
is Uni.new(0x1F6B5, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F6B5, 0x1F3FF, 0x200D, 0x2640⟆ 🚵🏿‍♀ E4.0 woman mountain biking: dark skin tone";
## 1F938 1F3FB                                ; fully-qualified     # 🤸🏻 E3.0 person cartwheeling: light skin tone # emoji-test.txt line #2426 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FB⟆ 🤸🏻 E3.0 person cartwheeling: light skin tone";
## 1F938 1F3FC                                ; fully-qualified     # 🤸🏼 E3.0 person cartwheeling: medium-light skin tone # emoji-test.txt line #2427 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FC⟆ 🤸🏼 E3.0 person cartwheeling: medium-light skin tone";
## 1F938 1F3FD                                ; fully-qualified     # 🤸🏽 E3.0 person cartwheeling: medium skin tone # emoji-test.txt line #2428 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FD⟆ 🤸🏽 E3.0 person cartwheeling: medium skin tone";
## 1F938 1F3FE                                ; fully-qualified     # 🤸🏾 E3.0 person cartwheeling: medium-dark skin tone # emoji-test.txt line #2429 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FE⟆ 🤸🏾 E3.0 person cartwheeling: medium-dark skin tone";
## 1F938 1F3FF                                ; fully-qualified     # 🤸🏿 E3.0 person cartwheeling: dark skin tone # emoji-test.txt line #2430 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FF⟆ 🤸🏿 E3.0 person cartwheeling: dark skin tone";
## 1F938 200D 2642 FE0F                       ; fully-qualified     # 🤸‍♂️ E4.0 man cartwheeling # emoji-test.txt line #2431 Emoji version 13.0
is Uni.new(0x1F938, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x200D, 0x2642, 0xFE0F⟆ 🤸‍♂️ E4.0 man cartwheeling";
## 1F938 200D 2642                            ; minimally-qualified # 🤸‍♂ E4.0 man cartwheeling # emoji-test.txt line #2432 Emoji version 13.0
is Uni.new(0x1F938, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F938, 0x200D, 0x2642⟆ 🤸‍♂ E4.0 man cartwheeling";
## 1F938 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🤸🏻‍♂️ E4.0 man cartwheeling: light skin tone # emoji-test.txt line #2433 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🤸🏻‍♂️ E4.0 man cartwheeling: light skin tone";
## 1F938 1F3FB 200D 2642                      ; minimally-qualified # 🤸🏻‍♂ E4.0 man cartwheeling: light skin tone # emoji-test.txt line #2434 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FB, 0x200D, 0x2642⟆ 🤸🏻‍♂ E4.0 man cartwheeling: light skin tone";
## 1F938 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🤸🏼‍♂️ E4.0 man cartwheeling: medium-light skin tone # emoji-test.txt line #2435 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🤸🏼‍♂️ E4.0 man cartwheeling: medium-light skin tone";
## 1F938 1F3FC 200D 2642                      ; minimally-qualified # 🤸🏼‍♂ E4.0 man cartwheeling: medium-light skin tone # emoji-test.txt line #2436 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FC, 0x200D, 0x2642⟆ 🤸🏼‍♂ E4.0 man cartwheeling: medium-light skin tone";
## 1F938 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🤸🏽‍♂️ E4.0 man cartwheeling: medium skin tone # emoji-test.txt line #2437 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🤸🏽‍♂️ E4.0 man cartwheeling: medium skin tone";
## 1F938 1F3FD 200D 2642                      ; minimally-qualified # 🤸🏽‍♂ E4.0 man cartwheeling: medium skin tone # emoji-test.txt line #2438 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FD, 0x200D, 0x2642⟆ 🤸🏽‍♂ E4.0 man cartwheeling: medium skin tone";
## 1F938 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🤸🏾‍♂️ E4.0 man cartwheeling: medium-dark skin tone # emoji-test.txt line #2439 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🤸🏾‍♂️ E4.0 man cartwheeling: medium-dark skin tone";
## 1F938 1F3FE 200D 2642                      ; minimally-qualified # 🤸🏾‍♂ E4.0 man cartwheeling: medium-dark skin tone # emoji-test.txt line #2440 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FE, 0x200D, 0x2642⟆ 🤸🏾‍♂ E4.0 man cartwheeling: medium-dark skin tone";
## 1F938 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🤸🏿‍♂️ E4.0 man cartwheeling: dark skin tone # emoji-test.txt line #2441 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🤸🏿‍♂️ E4.0 man cartwheeling: dark skin tone";
## 1F938 1F3FF 200D 2642                      ; minimally-qualified # 🤸🏿‍♂ E4.0 man cartwheeling: dark skin tone # emoji-test.txt line #2442 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FF, 0x200D, 0x2642⟆ 🤸🏿‍♂ E4.0 man cartwheeling: dark skin tone";
## 1F938 200D 2640 FE0F                       ; fully-qualified     # 🤸‍♀️ E4.0 woman cartwheeling # emoji-test.txt line #2443 Emoji version 13.0
is Uni.new(0x1F938, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x200D, 0x2640, 0xFE0F⟆ 🤸‍♀️ E4.0 woman cartwheeling";
## 1F938 200D 2640                            ; minimally-qualified # 🤸‍♀ E4.0 woman cartwheeling # emoji-test.txt line #2444 Emoji version 13.0
is Uni.new(0x1F938, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F938, 0x200D, 0x2640⟆ 🤸‍♀ E4.0 woman cartwheeling";
## 1F938 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🤸🏻‍♀️ E4.0 woman cartwheeling: light skin tone # emoji-test.txt line #2445 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🤸🏻‍♀️ E4.0 woman cartwheeling: light skin tone";
## 1F938 1F3FB 200D 2640                      ; minimally-qualified # 🤸🏻‍♀ E4.0 woman cartwheeling: light skin tone # emoji-test.txt line #2446 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FB, 0x200D, 0x2640⟆ 🤸🏻‍♀ E4.0 woman cartwheeling: light skin tone";
## 1F938 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🤸🏼‍♀️ E4.0 woman cartwheeling: medium-light skin tone # emoji-test.txt line #2447 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🤸🏼‍♀️ E4.0 woman cartwheeling: medium-light skin tone";
## 1F938 1F3FC 200D 2640                      ; minimally-qualified # 🤸🏼‍♀ E4.0 woman cartwheeling: medium-light skin tone # emoji-test.txt line #2448 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FC, 0x200D, 0x2640⟆ 🤸🏼‍♀ E4.0 woman cartwheeling: medium-light skin tone";
## 1F938 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🤸🏽‍♀️ E4.0 woman cartwheeling: medium skin tone # emoji-test.txt line #2449 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🤸🏽‍♀️ E4.0 woman cartwheeling: medium skin tone";
## 1F938 1F3FD 200D 2640                      ; minimally-qualified # 🤸🏽‍♀ E4.0 woman cartwheeling: medium skin tone # emoji-test.txt line #2450 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FD, 0x200D, 0x2640⟆ 🤸🏽‍♀ E4.0 woman cartwheeling: medium skin tone";
## 1F938 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🤸🏾‍♀️ E4.0 woman cartwheeling: medium-dark skin tone # emoji-test.txt line #2451 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🤸🏾‍♀️ E4.0 woman cartwheeling: medium-dark skin tone";
## 1F938 1F3FE 200D 2640                      ; minimally-qualified # 🤸🏾‍♀ E4.0 woman cartwheeling: medium-dark skin tone # emoji-test.txt line #2452 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FE, 0x200D, 0x2640⟆ 🤸🏾‍♀ E4.0 woman cartwheeling: medium-dark skin tone";
## 1F938 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🤸🏿‍♀️ E4.0 woman cartwheeling: dark skin tone # emoji-test.txt line #2453 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🤸🏿‍♀️ E4.0 woman cartwheeling: dark skin tone";
## 1F938 1F3FF 200D 2640                      ; minimally-qualified # 🤸🏿‍♀ E4.0 woman cartwheeling: dark skin tone # emoji-test.txt line #2454 Emoji version 13.0
is Uni.new(0x1F938, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F938, 0x1F3FF, 0x200D, 0x2640⟆ 🤸🏿‍♀ E4.0 woman cartwheeling: dark skin tone";
## 1F93C 200D 2642 FE0F                       ; fully-qualified     # 🤼‍♂️ E4.0 men wrestling # emoji-test.txt line #2456 Emoji version 13.0
is Uni.new(0x1F93C, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93C, 0x200D, 0x2642, 0xFE0F⟆ 🤼‍♂️ E4.0 men wrestling";
## 1F93C 200D 2642                            ; minimally-qualified # 🤼‍♂ E4.0 men wrestling # emoji-test.txt line #2457 Emoji version 13.0
is Uni.new(0x1F93C, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93C, 0x200D, 0x2642⟆ 🤼‍♂ E4.0 men wrestling";
## 1F93C 200D 2640 FE0F                       ; fully-qualified     # 🤼‍♀️ E4.0 women wrestling # emoji-test.txt line #2458 Emoji version 13.0
is Uni.new(0x1F93C, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93C, 0x200D, 0x2640, 0xFE0F⟆ 🤼‍♀️ E4.0 women wrestling";
## 1F93C 200D 2640                            ; minimally-qualified # 🤼‍♀ E4.0 women wrestling # emoji-test.txt line #2459 Emoji version 13.0
is Uni.new(0x1F93C, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93C, 0x200D, 0x2640⟆ 🤼‍♀ E4.0 women wrestling";
## 1F93D 1F3FB                                ; fully-qualified     # 🤽🏻 E3.0 person playing water polo: light skin tone # emoji-test.txt line #2461 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FB⟆ 🤽🏻 E3.0 person playing water polo: light skin tone";
## 1F93D 1F3FC                                ; fully-qualified     # 🤽🏼 E3.0 person playing water polo: medium-light skin tone # emoji-test.txt line #2462 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FC⟆ 🤽🏼 E3.0 person playing water polo: medium-light skin tone";
## 1F93D 1F3FD                                ; fully-qualified     # 🤽🏽 E3.0 person playing water polo: medium skin tone # emoji-test.txt line #2463 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FD⟆ 🤽🏽 E3.0 person playing water polo: medium skin tone";
## 1F93D 1F3FE                                ; fully-qualified     # 🤽🏾 E3.0 person playing water polo: medium-dark skin tone # emoji-test.txt line #2464 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FE⟆ 🤽🏾 E3.0 person playing water polo: medium-dark skin tone";
## 1F93D 1F3FF                                ; fully-qualified     # 🤽🏿 E3.0 person playing water polo: dark skin tone # emoji-test.txt line #2465 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FF⟆ 🤽🏿 E3.0 person playing water polo: dark skin tone";
## 1F93D 200D 2642 FE0F                       ; fully-qualified     # 🤽‍♂️ E4.0 man playing water polo # emoji-test.txt line #2466 Emoji version 13.0
is Uni.new(0x1F93D, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x200D, 0x2642, 0xFE0F⟆ 🤽‍♂️ E4.0 man playing water polo";
## 1F93D 200D 2642                            ; minimally-qualified # 🤽‍♂ E4.0 man playing water polo # emoji-test.txt line #2467 Emoji version 13.0
is Uni.new(0x1F93D, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93D, 0x200D, 0x2642⟆ 🤽‍♂ E4.0 man playing water polo";
## 1F93D 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🤽🏻‍♂️ E4.0 man playing water polo: light skin tone # emoji-test.txt line #2468 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🤽🏻‍♂️ E4.0 man playing water polo: light skin tone";
## 1F93D 1F3FB 200D 2642                      ; minimally-qualified # 🤽🏻‍♂ E4.0 man playing water polo: light skin tone # emoji-test.txt line #2469 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FB, 0x200D, 0x2642⟆ 🤽🏻‍♂ E4.0 man playing water polo: light skin tone";
## 1F93D 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🤽🏼‍♂️ E4.0 man playing water polo: medium-light skin tone # emoji-test.txt line #2470 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🤽🏼‍♂️ E4.0 man playing water polo: medium-light skin tone";
## 1F93D 1F3FC 200D 2642                      ; minimally-qualified # 🤽🏼‍♂ E4.0 man playing water polo: medium-light skin tone # emoji-test.txt line #2471 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FC, 0x200D, 0x2642⟆ 🤽🏼‍♂ E4.0 man playing water polo: medium-light skin tone";
## 1F93D 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🤽🏽‍♂️ E4.0 man playing water polo: medium skin tone # emoji-test.txt line #2472 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🤽🏽‍♂️ E4.0 man playing water polo: medium skin tone";
## 1F93D 1F3FD 200D 2642                      ; minimally-qualified # 🤽🏽‍♂ E4.0 man playing water polo: medium skin tone # emoji-test.txt line #2473 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FD, 0x200D, 0x2642⟆ 🤽🏽‍♂ E4.0 man playing water polo: medium skin tone";
## 1F93D 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🤽🏾‍♂️ E4.0 man playing water polo: medium-dark skin tone # emoji-test.txt line #2474 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🤽🏾‍♂️ E4.0 man playing water polo: medium-dark skin tone";
## 1F93D 1F3FE 200D 2642                      ; minimally-qualified # 🤽🏾‍♂ E4.0 man playing water polo: medium-dark skin tone # emoji-test.txt line #2475 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FE, 0x200D, 0x2642⟆ 🤽🏾‍♂ E4.0 man playing water polo: medium-dark skin tone";
## 1F93D 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🤽🏿‍♂️ E4.0 man playing water polo: dark skin tone # emoji-test.txt line #2476 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🤽🏿‍♂️ E4.0 man playing water polo: dark skin tone";
## 1F93D 1F3FF 200D 2642                      ; minimally-qualified # 🤽🏿‍♂ E4.0 man playing water polo: dark skin tone # emoji-test.txt line #2477 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FF, 0x200D, 0x2642⟆ 🤽🏿‍♂ E4.0 man playing water polo: dark skin tone";
## 1F93D 200D 2640 FE0F                       ; fully-qualified     # 🤽‍♀️ E4.0 woman playing water polo # emoji-test.txt line #2478 Emoji version 13.0
is Uni.new(0x1F93D, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x200D, 0x2640, 0xFE0F⟆ 🤽‍♀️ E4.0 woman playing water polo";
## 1F93D 200D 2640                            ; minimally-qualified # 🤽‍♀ E4.0 woman playing water polo # emoji-test.txt line #2479 Emoji version 13.0
is Uni.new(0x1F93D, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93D, 0x200D, 0x2640⟆ 🤽‍♀ E4.0 woman playing water polo";
## 1F93D 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🤽🏻‍♀️ E4.0 woman playing water polo: light skin tone # emoji-test.txt line #2480 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🤽🏻‍♀️ E4.0 woman playing water polo: light skin tone";
## 1F93D 1F3FB 200D 2640                      ; minimally-qualified # 🤽🏻‍♀ E4.0 woman playing water polo: light skin tone # emoji-test.txt line #2481 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FB, 0x200D, 0x2640⟆ 🤽🏻‍♀ E4.0 woman playing water polo: light skin tone";
## 1F93D 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🤽🏼‍♀️ E4.0 woman playing water polo: medium-light skin tone # emoji-test.txt line #2482 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🤽🏼‍♀️ E4.0 woman playing water polo: medium-light skin tone";
## 1F93D 1F3FC 200D 2640                      ; minimally-qualified # 🤽🏼‍♀ E4.0 woman playing water polo: medium-light skin tone # emoji-test.txt line #2483 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FC, 0x200D, 0x2640⟆ 🤽🏼‍♀ E4.0 woman playing water polo: medium-light skin tone";
## 1F93D 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🤽🏽‍♀️ E4.0 woman playing water polo: medium skin tone # emoji-test.txt line #2484 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🤽🏽‍♀️ E4.0 woman playing water polo: medium skin tone";
## 1F93D 1F3FD 200D 2640                      ; minimally-qualified # 🤽🏽‍♀ E4.0 woman playing water polo: medium skin tone # emoji-test.txt line #2485 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FD, 0x200D, 0x2640⟆ 🤽🏽‍♀ E4.0 woman playing water polo: medium skin tone";
## 1F93D 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🤽🏾‍♀️ E4.0 woman playing water polo: medium-dark skin tone # emoji-test.txt line #2486 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🤽🏾‍♀️ E4.0 woman playing water polo: medium-dark skin tone";
## 1F93D 1F3FE 200D 2640                      ; minimally-qualified # 🤽🏾‍♀ E4.0 woman playing water polo: medium-dark skin tone # emoji-test.txt line #2487 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FE, 0x200D, 0x2640⟆ 🤽🏾‍♀ E4.0 woman playing water polo: medium-dark skin tone";
## 1F93D 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🤽🏿‍♀️ E4.0 woman playing water polo: dark skin tone # emoji-test.txt line #2488 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🤽🏿‍♀️ E4.0 woman playing water polo: dark skin tone";
## 1F93D 1F3FF 200D 2640                      ; minimally-qualified # 🤽🏿‍♀ E4.0 woman playing water polo: dark skin tone # emoji-test.txt line #2489 Emoji version 13.0
is Uni.new(0x1F93D, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93D, 0x1F3FF, 0x200D, 0x2640⟆ 🤽🏿‍♀ E4.0 woman playing water polo: dark skin tone";
## 1F93E 1F3FB                                ; fully-qualified     # 🤾🏻 E3.0 person playing handball: light skin tone # emoji-test.txt line #2491 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FB⟆ 🤾🏻 E3.0 person playing handball: light skin tone";
## 1F93E 1F3FC                                ; fully-qualified     # 🤾🏼 E3.0 person playing handball: medium-light skin tone # emoji-test.txt line #2492 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FC⟆ 🤾🏼 E3.0 person playing handball: medium-light skin tone";
## 1F93E 1F3FD                                ; fully-qualified     # 🤾🏽 E3.0 person playing handball: medium skin tone # emoji-test.txt line #2493 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FD⟆ 🤾🏽 E3.0 person playing handball: medium skin tone";
## 1F93E 1F3FE                                ; fully-qualified     # 🤾🏾 E3.0 person playing handball: medium-dark skin tone # emoji-test.txt line #2494 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FE⟆ 🤾🏾 E3.0 person playing handball: medium-dark skin tone";
## 1F93E 1F3FF                                ; fully-qualified     # 🤾🏿 E3.0 person playing handball: dark skin tone # emoji-test.txt line #2495 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FF⟆ 🤾🏿 E3.0 person playing handball: dark skin tone";
## 1F93E 200D 2642 FE0F                       ; fully-qualified     # 🤾‍♂️ E4.0 man playing handball # emoji-test.txt line #2496 Emoji version 13.0
is Uni.new(0x1F93E, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x200D, 0x2642, 0xFE0F⟆ 🤾‍♂️ E4.0 man playing handball";
## 1F93E 200D 2642                            ; minimally-qualified # 🤾‍♂ E4.0 man playing handball # emoji-test.txt line #2497 Emoji version 13.0
is Uni.new(0x1F93E, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93E, 0x200D, 0x2642⟆ 🤾‍♂ E4.0 man playing handball";
## 1F93E 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🤾🏻‍♂️ E4.0 man playing handball: light skin tone # emoji-test.txt line #2498 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🤾🏻‍♂️ E4.0 man playing handball: light skin tone";
## 1F93E 1F3FB 200D 2642                      ; minimally-qualified # 🤾🏻‍♂ E4.0 man playing handball: light skin tone # emoji-test.txt line #2499 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FB, 0x200D, 0x2642⟆ 🤾🏻‍♂ E4.0 man playing handball: light skin tone";
## 1F93E 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🤾🏼‍♂️ E4.0 man playing handball: medium-light skin tone # emoji-test.txt line #2500 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🤾🏼‍♂️ E4.0 man playing handball: medium-light skin tone";
## 1F93E 1F3FC 200D 2642                      ; minimally-qualified # 🤾🏼‍♂ E4.0 man playing handball: medium-light skin tone # emoji-test.txt line #2501 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FC, 0x200D, 0x2642⟆ 🤾🏼‍♂ E4.0 man playing handball: medium-light skin tone";
## 1F93E 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🤾🏽‍♂️ E4.0 man playing handball: medium skin tone # emoji-test.txt line #2502 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🤾🏽‍♂️ E4.0 man playing handball: medium skin tone";
## 1F93E 1F3FD 200D 2642                      ; minimally-qualified # 🤾🏽‍♂ E4.0 man playing handball: medium skin tone # emoji-test.txt line #2503 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FD, 0x200D, 0x2642⟆ 🤾🏽‍♂ E4.0 man playing handball: medium skin tone";
## 1F93E 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🤾🏾‍♂️ E4.0 man playing handball: medium-dark skin tone # emoji-test.txt line #2504 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🤾🏾‍♂️ E4.0 man playing handball: medium-dark skin tone";
## 1F93E 1F3FE 200D 2642                      ; minimally-qualified # 🤾🏾‍♂ E4.0 man playing handball: medium-dark skin tone # emoji-test.txt line #2505 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FE, 0x200D, 0x2642⟆ 🤾🏾‍♂ E4.0 man playing handball: medium-dark skin tone";
## 1F93E 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🤾🏿‍♂️ E4.0 man playing handball: dark skin tone # emoji-test.txt line #2506 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🤾🏿‍♂️ E4.0 man playing handball: dark skin tone";
## 1F93E 1F3FF 200D 2642                      ; minimally-qualified # 🤾🏿‍♂ E4.0 man playing handball: dark skin tone # emoji-test.txt line #2507 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FF, 0x200D, 0x2642⟆ 🤾🏿‍♂ E4.0 man playing handball: dark skin tone";
## 1F93E 200D 2640 FE0F                       ; fully-qualified     # 🤾‍♀️ E4.0 woman playing handball # emoji-test.txt line #2508 Emoji version 13.0
is Uni.new(0x1F93E, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x200D, 0x2640, 0xFE0F⟆ 🤾‍♀️ E4.0 woman playing handball";
## 1F93E 200D 2640                            ; minimally-qualified # 🤾‍♀ E4.0 woman playing handball # emoji-test.txt line #2509 Emoji version 13.0
is Uni.new(0x1F93E, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93E, 0x200D, 0x2640⟆ 🤾‍♀ E4.0 woman playing handball";
## 1F93E 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🤾🏻‍♀️ E4.0 woman playing handball: light skin tone # emoji-test.txt line #2510 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🤾🏻‍♀️ E4.0 woman playing handball: light skin tone";
## 1F93E 1F3FB 200D 2640                      ; minimally-qualified # 🤾🏻‍♀ E4.0 woman playing handball: light skin tone # emoji-test.txt line #2511 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FB, 0x200D, 0x2640⟆ 🤾🏻‍♀ E4.0 woman playing handball: light skin tone";
## 1F93E 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🤾🏼‍♀️ E4.0 woman playing handball: medium-light skin tone # emoji-test.txt line #2512 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🤾🏼‍♀️ E4.0 woman playing handball: medium-light skin tone";
## 1F93E 1F3FC 200D 2640                      ; minimally-qualified # 🤾🏼‍♀ E4.0 woman playing handball: medium-light skin tone # emoji-test.txt line #2513 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FC, 0x200D, 0x2640⟆ 🤾🏼‍♀ E4.0 woman playing handball: medium-light skin tone";
## 1F93E 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🤾🏽‍♀️ E4.0 woman playing handball: medium skin tone # emoji-test.txt line #2514 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🤾🏽‍♀️ E4.0 woman playing handball: medium skin tone";
## 1F93E 1F3FD 200D 2640                      ; minimally-qualified # 🤾🏽‍♀ E4.0 woman playing handball: medium skin tone # emoji-test.txt line #2515 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FD, 0x200D, 0x2640⟆ 🤾🏽‍♀ E4.0 woman playing handball: medium skin tone";
## 1F93E 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🤾🏾‍♀️ E4.0 woman playing handball: medium-dark skin tone # emoji-test.txt line #2516 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🤾🏾‍♀️ E4.0 woman playing handball: medium-dark skin tone";
## 1F93E 1F3FE 200D 2640                      ; minimally-qualified # 🤾🏾‍♀ E4.0 woman playing handball: medium-dark skin tone # emoji-test.txt line #2517 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FE, 0x200D, 0x2640⟆ 🤾🏾‍♀ E4.0 woman playing handball: medium-dark skin tone";
## 1F93E 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🤾🏿‍♀️ E4.0 woman playing handball: dark skin tone # emoji-test.txt line #2518 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🤾🏿‍♀️ E4.0 woman playing handball: dark skin tone";
## 1F93E 1F3FF 200D 2640                      ; minimally-qualified # 🤾🏿‍♀ E4.0 woman playing handball: dark skin tone # emoji-test.txt line #2519 Emoji version 13.0
is Uni.new(0x1F93E, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F93E, 0x1F3FF, 0x200D, 0x2640⟆ 🤾🏿‍♀ E4.0 woman playing handball: dark skin tone";
## 1F939 1F3FB                                ; fully-qualified     # 🤹🏻 E3.0 person juggling: light skin tone # emoji-test.txt line #2521 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FB⟆ 🤹🏻 E3.0 person juggling: light skin tone";
## 1F939 1F3FC                                ; fully-qualified     # 🤹🏼 E3.0 person juggling: medium-light skin tone # emoji-test.txt line #2522 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FC⟆ 🤹🏼 E3.0 person juggling: medium-light skin tone";
## 1F939 1F3FD                                ; fully-qualified     # 🤹🏽 E3.0 person juggling: medium skin tone # emoji-test.txt line #2523 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FD⟆ 🤹🏽 E3.0 person juggling: medium skin tone";
## 1F939 1F3FE                                ; fully-qualified     # 🤹🏾 E3.0 person juggling: medium-dark skin tone # emoji-test.txt line #2524 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FE⟆ 🤹🏾 E3.0 person juggling: medium-dark skin tone";
## 1F939 1F3FF                                ; fully-qualified     # 🤹🏿 E3.0 person juggling: dark skin tone # emoji-test.txt line #2525 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FF⟆ 🤹🏿 E3.0 person juggling: dark skin tone";
## 1F939 200D 2642 FE0F                       ; fully-qualified     # 🤹‍♂️ E4.0 man juggling # emoji-test.txt line #2526 Emoji version 13.0
is Uni.new(0x1F939, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x200D, 0x2642, 0xFE0F⟆ 🤹‍♂️ E4.0 man juggling";
## 1F939 200D 2642                            ; minimally-qualified # 🤹‍♂ E4.0 man juggling # emoji-test.txt line #2527 Emoji version 13.0
is Uni.new(0x1F939, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F939, 0x200D, 0x2642⟆ 🤹‍♂ E4.0 man juggling";
## 1F939 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🤹🏻‍♂️ E4.0 man juggling: light skin tone # emoji-test.txt line #2528 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🤹🏻‍♂️ E4.0 man juggling: light skin tone";
## 1F939 1F3FB 200D 2642                      ; minimally-qualified # 🤹🏻‍♂ E4.0 man juggling: light skin tone # emoji-test.txt line #2529 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FB, 0x200D, 0x2642⟆ 🤹🏻‍♂ E4.0 man juggling: light skin tone";
## 1F939 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🤹🏼‍♂️ E4.0 man juggling: medium-light skin tone # emoji-test.txt line #2530 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🤹🏼‍♂️ E4.0 man juggling: medium-light skin tone";
## 1F939 1F3FC 200D 2642                      ; minimally-qualified # 🤹🏼‍♂ E4.0 man juggling: medium-light skin tone # emoji-test.txt line #2531 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FC, 0x200D, 0x2642⟆ 🤹🏼‍♂ E4.0 man juggling: medium-light skin tone";
## 1F939 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🤹🏽‍♂️ E4.0 man juggling: medium skin tone # emoji-test.txt line #2532 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🤹🏽‍♂️ E4.0 man juggling: medium skin tone";
## 1F939 1F3FD 200D 2642                      ; minimally-qualified # 🤹🏽‍♂ E4.0 man juggling: medium skin tone # emoji-test.txt line #2533 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FD, 0x200D, 0x2642⟆ 🤹🏽‍♂ E4.0 man juggling: medium skin tone";
## 1F939 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🤹🏾‍♂️ E4.0 man juggling: medium-dark skin tone # emoji-test.txt line #2534 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🤹🏾‍♂️ E4.0 man juggling: medium-dark skin tone";
## 1F939 1F3FE 200D 2642                      ; minimally-qualified # 🤹🏾‍♂ E4.0 man juggling: medium-dark skin tone # emoji-test.txt line #2535 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FE, 0x200D, 0x2642⟆ 🤹🏾‍♂ E4.0 man juggling: medium-dark skin tone";
## 1F939 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🤹🏿‍♂️ E4.0 man juggling: dark skin tone # emoji-test.txt line #2536 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🤹🏿‍♂️ E4.0 man juggling: dark skin tone";
## 1F939 1F3FF 200D 2642                      ; minimally-qualified # 🤹🏿‍♂ E4.0 man juggling: dark skin tone # emoji-test.txt line #2537 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FF, 0x200D, 0x2642⟆ 🤹🏿‍♂ E4.0 man juggling: dark skin tone";
## 1F939 200D 2640 FE0F                       ; fully-qualified     # 🤹‍♀️ E4.0 woman juggling # emoji-test.txt line #2538 Emoji version 13.0
is Uni.new(0x1F939, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x200D, 0x2640, 0xFE0F⟆ 🤹‍♀️ E4.0 woman juggling";
## 1F939 200D 2640                            ; minimally-qualified # 🤹‍♀ E4.0 woman juggling # emoji-test.txt line #2539 Emoji version 13.0
is Uni.new(0x1F939, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F939, 0x200D, 0x2640⟆ 🤹‍♀ E4.0 woman juggling";
## 1F939 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🤹🏻‍♀️ E4.0 woman juggling: light skin tone # emoji-test.txt line #2540 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🤹🏻‍♀️ E4.0 woman juggling: light skin tone";
## 1F939 1F3FB 200D 2640                      ; minimally-qualified # 🤹🏻‍♀ E4.0 woman juggling: light skin tone # emoji-test.txt line #2541 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FB, 0x200D, 0x2640⟆ 🤹🏻‍♀ E4.0 woman juggling: light skin tone";
## 1F939 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🤹🏼‍♀️ E4.0 woman juggling: medium-light skin tone # emoji-test.txt line #2542 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🤹🏼‍♀️ E4.0 woman juggling: medium-light skin tone";
## 1F939 1F3FC 200D 2640                      ; minimally-qualified # 🤹🏼‍♀ E4.0 woman juggling: medium-light skin tone # emoji-test.txt line #2543 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FC, 0x200D, 0x2640⟆ 🤹🏼‍♀ E4.0 woman juggling: medium-light skin tone";
## 1F939 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🤹🏽‍♀️ E4.0 woman juggling: medium skin tone # emoji-test.txt line #2544 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🤹🏽‍♀️ E4.0 woman juggling: medium skin tone";
## 1F939 1F3FD 200D 2640                      ; minimally-qualified # 🤹🏽‍♀ E4.0 woman juggling: medium skin tone # emoji-test.txt line #2545 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FD, 0x200D, 0x2640⟆ 🤹🏽‍♀ E4.0 woman juggling: medium skin tone";
## 1F939 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🤹🏾‍♀️ E4.0 woman juggling: medium-dark skin tone # emoji-test.txt line #2546 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🤹🏾‍♀️ E4.0 woman juggling: medium-dark skin tone";
## 1F939 1F3FE 200D 2640                      ; minimally-qualified # 🤹🏾‍♀ E4.0 woman juggling: medium-dark skin tone # emoji-test.txt line #2547 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FE, 0x200D, 0x2640⟆ 🤹🏾‍♀ E4.0 woman juggling: medium-dark skin tone";
## 1F939 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🤹🏿‍♀️ E4.0 woman juggling: dark skin tone # emoji-test.txt line #2548 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🤹🏿‍♀️ E4.0 woman juggling: dark skin tone";
## 1F939 1F3FF 200D 2640                      ; minimally-qualified # 🤹🏿‍♀ E4.0 woman juggling: dark skin tone # emoji-test.txt line #2549 Emoji version 13.0
is Uni.new(0x1F939, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F939, 0x1F3FF, 0x200D, 0x2640⟆ 🤹🏿‍♀ E4.0 woman juggling: dark skin tone";
## 1F9D8 1F3FB                                ; fully-qualified     # 🧘🏻 E5.0 person in lotus position: light skin tone # emoji-test.txt line #2553 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FB⟆ 🧘🏻 E5.0 person in lotus position: light skin tone";
## 1F9D8 1F3FC                                ; fully-qualified     # 🧘🏼 E5.0 person in lotus position: medium-light skin tone # emoji-test.txt line #2554 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FC⟆ 🧘🏼 E5.0 person in lotus position: medium-light skin tone";
## 1F9D8 1F3FD                                ; fully-qualified     # 🧘🏽 E5.0 person in lotus position: medium skin tone # emoji-test.txt line #2555 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FD⟆ 🧘🏽 E5.0 person in lotus position: medium skin tone";
## 1F9D8 1F3FE                                ; fully-qualified     # 🧘🏾 E5.0 person in lotus position: medium-dark skin tone # emoji-test.txt line #2556 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FE⟆ 🧘🏾 E5.0 person in lotus position: medium-dark skin tone";
## 1F9D8 1F3FF                                ; fully-qualified     # 🧘🏿 E5.0 person in lotus position: dark skin tone # emoji-test.txt line #2557 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FF⟆ 🧘🏿 E5.0 person in lotus position: dark skin tone";
## 1F9D8 200D 2642 FE0F                       ; fully-qualified     # 🧘‍♂️ E5.0 man in lotus position # emoji-test.txt line #2558 Emoji version 13.0
is Uni.new(0x1F9D8, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x200D, 0x2642, 0xFE0F⟆ 🧘‍♂️ E5.0 man in lotus position";
## 1F9D8 200D 2642                            ; minimally-qualified # 🧘‍♂ E5.0 man in lotus position # emoji-test.txt line #2559 Emoji version 13.0
is Uni.new(0x1F9D8, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x200D, 0x2642⟆ 🧘‍♂ E5.0 man in lotus position";
## 1F9D8 1F3FB 200D 2642 FE0F                 ; fully-qualified     # 🧘🏻‍♂️ E5.0 man in lotus position: light skin tone # emoji-test.txt line #2560 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FB, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FB, 0x200D, 0x2642, 0xFE0F⟆ 🧘🏻‍♂️ E5.0 man in lotus position: light skin tone";
## 1F9D8 1F3FB 200D 2642                      ; minimally-qualified # 🧘🏻‍♂ E5.0 man in lotus position: light skin tone # emoji-test.txt line #2561 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FB, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FB, 0x200D, 0x2642⟆ 🧘🏻‍♂ E5.0 man in lotus position: light skin tone";
## 1F9D8 1F3FC 200D 2642 FE0F                 ; fully-qualified     # 🧘🏼‍♂️ E5.0 man in lotus position: medium-light skin tone # emoji-test.txt line #2562 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FC, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FC, 0x200D, 0x2642, 0xFE0F⟆ 🧘🏼‍♂️ E5.0 man in lotus position: medium-light skin tone";
## 1F9D8 1F3FC 200D 2642                      ; minimally-qualified # 🧘🏼‍♂ E5.0 man in lotus position: medium-light skin tone # emoji-test.txt line #2563 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FC, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FC, 0x200D, 0x2642⟆ 🧘🏼‍♂ E5.0 man in lotus position: medium-light skin tone";
## 1F9D8 1F3FD 200D 2642 FE0F                 ; fully-qualified     # 🧘🏽‍♂️ E5.0 man in lotus position: medium skin tone # emoji-test.txt line #2564 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FD, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FD, 0x200D, 0x2642, 0xFE0F⟆ 🧘🏽‍♂️ E5.0 man in lotus position: medium skin tone";
## 1F9D8 1F3FD 200D 2642                      ; minimally-qualified # 🧘🏽‍♂ E5.0 man in lotus position: medium skin tone # emoji-test.txt line #2565 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FD, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FD, 0x200D, 0x2642⟆ 🧘🏽‍♂ E5.0 man in lotus position: medium skin tone";
## 1F9D8 1F3FE 200D 2642 FE0F                 ; fully-qualified     # 🧘🏾‍♂️ E5.0 man in lotus position: medium-dark skin tone # emoji-test.txt line #2566 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FE, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FE, 0x200D, 0x2642, 0xFE0F⟆ 🧘🏾‍♂️ E5.0 man in lotus position: medium-dark skin tone";
## 1F9D8 1F3FE 200D 2642                      ; minimally-qualified # 🧘🏾‍♂ E5.0 man in lotus position: medium-dark skin tone # emoji-test.txt line #2567 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FE, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FE, 0x200D, 0x2642⟆ 🧘🏾‍♂ E5.0 man in lotus position: medium-dark skin tone";
## 1F9D8 1F3FF 200D 2642 FE0F                 ; fully-qualified     # 🧘🏿‍♂️ E5.0 man in lotus position: dark skin tone # emoji-test.txt line #2568 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FF, 0x200D, 0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FF, 0x200D, 0x2642, 0xFE0F⟆ 🧘🏿‍♂️ E5.0 man in lotus position: dark skin tone";
## 1F9D8 1F3FF 200D 2642                      ; minimally-qualified # 🧘🏿‍♂ E5.0 man in lotus position: dark skin tone # emoji-test.txt line #2569 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FF, 0x200D, 0x2642).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FF, 0x200D, 0x2642⟆ 🧘🏿‍♂ E5.0 man in lotus position: dark skin tone";
## 1F9D8 200D 2640 FE0F                       ; fully-qualified     # 🧘‍♀️ E5.0 woman in lotus position # emoji-test.txt line #2570 Emoji version 13.0
is Uni.new(0x1F9D8, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x200D, 0x2640, 0xFE0F⟆ 🧘‍♀️ E5.0 woman in lotus position";
## 1F9D8 200D 2640                            ; minimally-qualified # 🧘‍♀ E5.0 woman in lotus position # emoji-test.txt line #2571 Emoji version 13.0
is Uni.new(0x1F9D8, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x200D, 0x2640⟆ 🧘‍♀ E5.0 woman in lotus position";
## 1F9D8 1F3FB 200D 2640 FE0F                 ; fully-qualified     # 🧘🏻‍♀️ E5.0 woman in lotus position: light skin tone # emoji-test.txt line #2572 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FB, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FB, 0x200D, 0x2640, 0xFE0F⟆ 🧘🏻‍♀️ E5.0 woman in lotus position: light skin tone";
## 1F9D8 1F3FB 200D 2640                      ; minimally-qualified # 🧘🏻‍♀ E5.0 woman in lotus position: light skin tone # emoji-test.txt line #2573 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FB, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FB, 0x200D, 0x2640⟆ 🧘🏻‍♀ E5.0 woman in lotus position: light skin tone";
## 1F9D8 1F3FC 200D 2640 FE0F                 ; fully-qualified     # 🧘🏼‍♀️ E5.0 woman in lotus position: medium-light skin tone # emoji-test.txt line #2574 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FC, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FC, 0x200D, 0x2640, 0xFE0F⟆ 🧘🏼‍♀️ E5.0 woman in lotus position: medium-light skin tone";
## 1F9D8 1F3FC 200D 2640                      ; minimally-qualified # 🧘🏼‍♀ E5.0 woman in lotus position: medium-light skin tone # emoji-test.txt line #2575 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FC, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FC, 0x200D, 0x2640⟆ 🧘🏼‍♀ E5.0 woman in lotus position: medium-light skin tone";
## 1F9D8 1F3FD 200D 2640 FE0F                 ; fully-qualified     # 🧘🏽‍♀️ E5.0 woman in lotus position: medium skin tone # emoji-test.txt line #2576 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FD, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FD, 0x200D, 0x2640, 0xFE0F⟆ 🧘🏽‍♀️ E5.0 woman in lotus position: medium skin tone";
## 1F9D8 1F3FD 200D 2640                      ; minimally-qualified # 🧘🏽‍♀ E5.0 woman in lotus position: medium skin tone # emoji-test.txt line #2577 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FD, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FD, 0x200D, 0x2640⟆ 🧘🏽‍♀ E5.0 woman in lotus position: medium skin tone";
## 1F9D8 1F3FE 200D 2640 FE0F                 ; fully-qualified     # 🧘🏾‍♀️ E5.0 woman in lotus position: medium-dark skin tone # emoji-test.txt line #2578 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FE, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FE, 0x200D, 0x2640, 0xFE0F⟆ 🧘🏾‍♀️ E5.0 woman in lotus position: medium-dark skin tone";
## 1F9D8 1F3FE 200D 2640                      ; minimally-qualified # 🧘🏾‍♀ E5.0 woman in lotus position: medium-dark skin tone # emoji-test.txt line #2579 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FE, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FE, 0x200D, 0x2640⟆ 🧘🏾‍♀ E5.0 woman in lotus position: medium-dark skin tone";
## 1F9D8 1F3FF 200D 2640 FE0F                 ; fully-qualified     # 🧘🏿‍♀️ E5.0 woman in lotus position: dark skin tone # emoji-test.txt line #2580 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FF, 0x200D, 0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FF, 0x200D, 0x2640, 0xFE0F⟆ 🧘🏿‍♀️ E5.0 woman in lotus position: dark skin tone";
## 1F9D8 1F3FF 200D 2640                      ; minimally-qualified # 🧘🏿‍♀ E5.0 woman in lotus position: dark skin tone # emoji-test.txt line #2581 Emoji version 13.0
is Uni.new(0x1F9D8, 0x1F3FF, 0x200D, 0x2640).Str.chars, 1, "Codes: ⟅0x1F9D8, 0x1F3FF, 0x200D, 0x2640⟆ 🧘🏿‍♀ E5.0 woman in lotus position: dark skin tone";
## 1F6C0 1F3FB                                ; fully-qualified     # 🛀🏻 E1.0 person taking bath: light skin tone # emoji-test.txt line #2583 Emoji version 13.0
is Uni.new(0x1F6C0, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F6C0, 0x1F3FB⟆ 🛀🏻 E1.0 person taking bath: light skin tone";
## 1F6C0 1F3FC                                ; fully-qualified     # 🛀🏼 E1.0 person taking bath: medium-light skin tone # emoji-test.txt line #2584 Emoji version 13.0
is Uni.new(0x1F6C0, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F6C0, 0x1F3FC⟆ 🛀🏼 E1.0 person taking bath: medium-light skin tone";
## 1F6C0 1F3FD                                ; fully-qualified     # 🛀🏽 E1.0 person taking bath: medium skin tone # emoji-test.txt line #2585 Emoji version 13.0
is Uni.new(0x1F6C0, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F6C0, 0x1F3FD⟆ 🛀🏽 E1.0 person taking bath: medium skin tone";
## 1F6C0 1F3FE                                ; fully-qualified     # 🛀🏾 E1.0 person taking bath: medium-dark skin tone # emoji-test.txt line #2586 Emoji version 13.0
is Uni.new(0x1F6C0, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F6C0, 0x1F3FE⟆ 🛀🏾 E1.0 person taking bath: medium-dark skin tone";
## 1F6C0 1F3FF                                ; fully-qualified     # 🛀🏿 E1.0 person taking bath: dark skin tone # emoji-test.txt line #2587 Emoji version 13.0
is Uni.new(0x1F6C0, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F6C0, 0x1F3FF⟆ 🛀🏿 E1.0 person taking bath: dark skin tone";
## 1F6CC 1F3FB                                ; fully-qualified     # 🛌🏻 E4.0 person in bed: light skin tone # emoji-test.txt line #2589 Emoji version 13.0
is Uni.new(0x1F6CC, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F6CC, 0x1F3FB⟆ 🛌🏻 E4.0 person in bed: light skin tone";
## 1F6CC 1F3FC                                ; fully-qualified     # 🛌🏼 E4.0 person in bed: medium-light skin tone # emoji-test.txt line #2590 Emoji version 13.0
is Uni.new(0x1F6CC, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F6CC, 0x1F3FC⟆ 🛌🏼 E4.0 person in bed: medium-light skin tone";
## 1F6CC 1F3FD                                ; fully-qualified     # 🛌🏽 E4.0 person in bed: medium skin tone # emoji-test.txt line #2591 Emoji version 13.0
is Uni.new(0x1F6CC, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F6CC, 0x1F3FD⟆ 🛌🏽 E4.0 person in bed: medium skin tone";
## 1F6CC 1F3FE                                ; fully-qualified     # 🛌🏾 E4.0 person in bed: medium-dark skin tone # emoji-test.txt line #2592 Emoji version 13.0
is Uni.new(0x1F6CC, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F6CC, 0x1F3FE⟆ 🛌🏾 E4.0 person in bed: medium-dark skin tone";
## 1F6CC 1F3FF                                ; fully-qualified     # 🛌🏿 E4.0 person in bed: dark skin tone # emoji-test.txt line #2593 Emoji version 13.0
is Uni.new(0x1F6CC, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F6CC, 0x1F3FF⟆ 🛌🏿 E4.0 person in bed: dark skin tone";
## 1F9D1 200D 1F91D 200D 1F9D1                ; fully-qualified     # 🧑‍🤝‍🧑 E12.0 people holding hands # emoji-test.txt line #2596 Emoji version 13.0
is Uni.new(0x1F9D1, 0x200D, 0x1F91D, 0x200D, 0x1F9D1).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x200D, 0x1F91D, 0x200D, 0x1F9D1⟆ 🧑‍🤝‍🧑 E12.0 people holding hands";
## 1F9D1 1F3FB 200D 1F91D 200D 1F9D1 1F3FB    ; fully-qualified     # 🧑🏻‍🤝‍🧑🏻 E12.0 people holding hands: light skin tone # emoji-test.txt line #2597 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FB⟆ 🧑🏻‍🤝‍🧑🏻 E12.0 people holding hands: light skin tone";
## 1F9D1 1F3FB 200D 1F91D 200D 1F9D1 1F3FC    ; fully-qualified     # 🧑🏻‍🤝‍🧑🏼 E12.1 people holding hands: light skin tone, medium-light skin tone # emoji-test.txt line #2598 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FC⟆ 🧑🏻‍🤝‍🧑🏼 E12.1 people holding hands: light skin tone, medium-light skin tone";
## 1F9D1 1F3FB 200D 1F91D 200D 1F9D1 1F3FD    ; fully-qualified     # 🧑🏻‍🤝‍🧑🏽 E12.1 people holding hands: light skin tone, medium skin tone # emoji-test.txt line #2599 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FD⟆ 🧑🏻‍🤝‍🧑🏽 E12.1 people holding hands: light skin tone, medium skin tone";
## 1F9D1 1F3FB 200D 1F91D 200D 1F9D1 1F3FE    ; fully-qualified     # 🧑🏻‍🤝‍🧑🏾 E12.1 people holding hands: light skin tone, medium-dark skin tone # emoji-test.txt line #2600 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FE⟆ 🧑🏻‍🤝‍🧑🏾 E12.1 people holding hands: light skin tone, medium-dark skin tone";
## 1F9D1 1F3FB 200D 1F91D 200D 1F9D1 1F3FF    ; fully-qualified     # 🧑🏻‍🤝‍🧑🏿 E12.1 people holding hands: light skin tone, dark skin tone # emoji-test.txt line #2601 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FF⟆ 🧑🏻‍🤝‍🧑🏿 E12.1 people holding hands: light skin tone, dark skin tone";
## 1F9D1 1F3FC 200D 1F91D 200D 1F9D1 1F3FB    ; fully-qualified     # 🧑🏼‍🤝‍🧑🏻 E12.0 people holding hands: medium-light skin tone, light skin tone # emoji-test.txt line #2602 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FB⟆ 🧑🏼‍🤝‍🧑🏻 E12.0 people holding hands: medium-light skin tone, light skin tone";
## 1F9D1 1F3FC 200D 1F91D 200D 1F9D1 1F3FC    ; fully-qualified     # 🧑🏼‍🤝‍🧑🏼 E12.0 people holding hands: medium-light skin tone # emoji-test.txt line #2603 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FC⟆ 🧑🏼‍🤝‍🧑🏼 E12.0 people holding hands: medium-light skin tone";
## 1F9D1 1F3FC 200D 1F91D 200D 1F9D1 1F3FD    ; fully-qualified     # 🧑🏼‍🤝‍🧑🏽 E12.1 people holding hands: medium-light skin tone, medium skin tone # emoji-test.txt line #2604 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FD⟆ 🧑🏼‍🤝‍🧑🏽 E12.1 people holding hands: medium-light skin tone, medium skin tone";
## 1F9D1 1F3FC 200D 1F91D 200D 1F9D1 1F3FE    ; fully-qualified     # 🧑🏼‍🤝‍🧑🏾 E12.1 people holding hands: medium-light skin tone, medium-dark skin tone # emoji-test.txt line #2605 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FE⟆ 🧑🏼‍🤝‍🧑🏾 E12.1 people holding hands: medium-light skin tone, medium-dark skin tone";
## 1F9D1 1F3FC 200D 1F91D 200D 1F9D1 1F3FF    ; fully-qualified     # 🧑🏼‍🤝‍🧑🏿 E12.1 people holding hands: medium-light skin tone, dark skin tone # emoji-test.txt line #2606 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FF⟆ 🧑🏼‍🤝‍🧑🏿 E12.1 people holding hands: medium-light skin tone, dark skin tone";
## 1F9D1 1F3FD 200D 1F91D 200D 1F9D1 1F3FB    ; fully-qualified     # 🧑🏽‍🤝‍🧑🏻 E12.0 people holding hands: medium skin tone, light skin tone # emoji-test.txt line #2607 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FB⟆ 🧑🏽‍🤝‍🧑🏻 E12.0 people holding hands: medium skin tone, light skin tone";
## 1F9D1 1F3FD 200D 1F91D 200D 1F9D1 1F3FC    ; fully-qualified     # 🧑🏽‍🤝‍🧑🏼 E12.0 people holding hands: medium skin tone, medium-light skin tone # emoji-test.txt line #2608 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FC⟆ 🧑🏽‍🤝‍🧑🏼 E12.0 people holding hands: medium skin tone, medium-light skin tone";
## 1F9D1 1F3FD 200D 1F91D 200D 1F9D1 1F3FD    ; fully-qualified     # 🧑🏽‍🤝‍🧑🏽 E12.0 people holding hands: medium skin tone # emoji-test.txt line #2609 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FD⟆ 🧑🏽‍🤝‍🧑🏽 E12.0 people holding hands: medium skin tone";
## 1F9D1 1F3FD 200D 1F91D 200D 1F9D1 1F3FE    ; fully-qualified     # 🧑🏽‍🤝‍🧑🏾 E12.1 people holding hands: medium skin tone, medium-dark skin tone # emoji-test.txt line #2610 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FE⟆ 🧑🏽‍🤝‍🧑🏾 E12.1 people holding hands: medium skin tone, medium-dark skin tone";
## 1F9D1 1F3FD 200D 1F91D 200D 1F9D1 1F3FF    ; fully-qualified     # 🧑🏽‍🤝‍🧑🏿 E12.1 people holding hands: medium skin tone, dark skin tone # emoji-test.txt line #2611 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FF⟆ 🧑🏽‍🤝‍🧑🏿 E12.1 people holding hands: medium skin tone, dark skin tone";
## 1F9D1 1F3FE 200D 1F91D 200D 1F9D1 1F3FB    ; fully-qualified     # 🧑🏾‍🤝‍🧑🏻 E12.0 people holding hands: medium-dark skin tone, light skin tone # emoji-test.txt line #2612 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FB⟆ 🧑🏾‍🤝‍🧑🏻 E12.0 people holding hands: medium-dark skin tone, light skin tone";
## 1F9D1 1F3FE 200D 1F91D 200D 1F9D1 1F3FC    ; fully-qualified     # 🧑🏾‍🤝‍🧑🏼 E12.0 people holding hands: medium-dark skin tone, medium-light skin tone # emoji-test.txt line #2613 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FC⟆ 🧑🏾‍🤝‍🧑🏼 E12.0 people holding hands: medium-dark skin tone, medium-light skin tone";
## 1F9D1 1F3FE 200D 1F91D 200D 1F9D1 1F3FD    ; fully-qualified     # 🧑🏾‍🤝‍🧑🏽 E12.0 people holding hands: medium-dark skin tone, medium skin tone # emoji-test.txt line #2614 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FD⟆ 🧑🏾‍🤝‍🧑🏽 E12.0 people holding hands: medium-dark skin tone, medium skin tone";
## 1F9D1 1F3FE 200D 1F91D 200D 1F9D1 1F3FE    ; fully-qualified     # 🧑🏾‍🤝‍🧑🏾 E12.0 people holding hands: medium-dark skin tone # emoji-test.txt line #2615 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FE⟆ 🧑🏾‍🤝‍🧑🏾 E12.0 people holding hands: medium-dark skin tone";
## 1F9D1 1F3FE 200D 1F91D 200D 1F9D1 1F3FF    ; fully-qualified     # 🧑🏾‍🤝‍🧑🏿 E12.1 people holding hands: medium-dark skin tone, dark skin tone # emoji-test.txt line #2616 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FF⟆ 🧑🏾‍🤝‍🧑🏿 E12.1 people holding hands: medium-dark skin tone, dark skin tone";
## 1F9D1 1F3FF 200D 1F91D 200D 1F9D1 1F3FB    ; fully-qualified     # 🧑🏿‍🤝‍🧑🏻 E12.0 people holding hands: dark skin tone, light skin tone # emoji-test.txt line #2617 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FB⟆ 🧑🏿‍🤝‍🧑🏻 E12.0 people holding hands: dark skin tone, light skin tone";
## 1F9D1 1F3FF 200D 1F91D 200D 1F9D1 1F3FC    ; fully-qualified     # 🧑🏿‍🤝‍🧑🏼 E12.0 people holding hands: dark skin tone, medium-light skin tone # emoji-test.txt line #2618 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FC⟆ 🧑🏿‍🤝‍🧑🏼 E12.0 people holding hands: dark skin tone, medium-light skin tone";
## 1F9D1 1F3FF 200D 1F91D 200D 1F9D1 1F3FD    ; fully-qualified     # 🧑🏿‍🤝‍🧑🏽 E12.0 people holding hands: dark skin tone, medium skin tone # emoji-test.txt line #2619 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FD⟆ 🧑🏿‍🤝‍🧑🏽 E12.0 people holding hands: dark skin tone, medium skin tone";
## 1F9D1 1F3FF 200D 1F91D 200D 1F9D1 1F3FE    ; fully-qualified     # 🧑🏿‍🤝‍🧑🏾 E12.0 people holding hands: dark skin tone, medium-dark skin tone # emoji-test.txt line #2620 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FE⟆ 🧑🏿‍🤝‍🧑🏾 E12.0 people holding hands: dark skin tone, medium-dark skin tone";
## 1F9D1 1F3FF 200D 1F91D 200D 1F9D1 1F3FF    ; fully-qualified     # 🧑🏿‍🤝‍🧑🏿 E12.0 people holding hands: dark skin tone # emoji-test.txt line #2621 Emoji version 13.0
is Uni.new(0x1F9D1, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F9D1, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F9D1, 0x1F3FF⟆ 🧑🏿‍🤝‍🧑🏿 E12.0 people holding hands: dark skin tone";
## 1F46D 1F3FB                                ; fully-qualified     # 👭🏻 E12.0 women holding hands: light skin tone # emoji-test.txt line #2623 Emoji version 13.0
is Uni.new(0x1F46D, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F46D, 0x1F3FB⟆ 👭🏻 E12.0 women holding hands: light skin tone";
## 1F469 1F3FB 200D 1F91D 200D 1F469 1F3FC    ; fully-qualified     # 👩🏻‍🤝‍👩🏼 E12.1 women holding hands: light skin tone, medium-light skin tone # emoji-test.txt line #2624 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FC⟆ 👩🏻‍🤝‍👩🏼 E12.1 women holding hands: light skin tone, medium-light skin tone";
## 1F469 1F3FB 200D 1F91D 200D 1F469 1F3FD    ; fully-qualified     # 👩🏻‍🤝‍👩🏽 E12.1 women holding hands: light skin tone, medium skin tone # emoji-test.txt line #2625 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FD⟆ 👩🏻‍🤝‍👩🏽 E12.1 women holding hands: light skin tone, medium skin tone";
## 1F469 1F3FB 200D 1F91D 200D 1F469 1F3FE    ; fully-qualified     # 👩🏻‍🤝‍👩🏾 E12.1 women holding hands: light skin tone, medium-dark skin tone # emoji-test.txt line #2626 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FE⟆ 👩🏻‍🤝‍👩🏾 E12.1 women holding hands: light skin tone, medium-dark skin tone";
## 1F469 1F3FB 200D 1F91D 200D 1F469 1F3FF    ; fully-qualified     # 👩🏻‍🤝‍👩🏿 E12.1 women holding hands: light skin tone, dark skin tone # emoji-test.txt line #2627 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FF⟆ 👩🏻‍🤝‍👩🏿 E12.1 women holding hands: light skin tone, dark skin tone";
## 1F469 1F3FC 200D 1F91D 200D 1F469 1F3FB    ; fully-qualified     # 👩🏼‍🤝‍👩🏻 E12.0 women holding hands: medium-light skin tone, light skin tone # emoji-test.txt line #2628 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FB⟆ 👩🏼‍🤝‍👩🏻 E12.0 women holding hands: medium-light skin tone, light skin tone";
## 1F46D 1F3FC                                ; fully-qualified     # 👭🏼 E12.0 women holding hands: medium-light skin tone # emoji-test.txt line #2629 Emoji version 13.0
is Uni.new(0x1F46D, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F46D, 0x1F3FC⟆ 👭🏼 E12.0 women holding hands: medium-light skin tone";
## 1F469 1F3FC 200D 1F91D 200D 1F469 1F3FD    ; fully-qualified     # 👩🏼‍🤝‍👩🏽 E12.1 women holding hands: medium-light skin tone, medium skin tone # emoji-test.txt line #2630 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FD⟆ 👩🏼‍🤝‍👩🏽 E12.1 women holding hands: medium-light skin tone, medium skin tone";
## 1F469 1F3FC 200D 1F91D 200D 1F469 1F3FE    ; fully-qualified     # 👩🏼‍🤝‍👩🏾 E12.1 women holding hands: medium-light skin tone, medium-dark skin tone # emoji-test.txt line #2631 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FE⟆ 👩🏼‍🤝‍👩🏾 E12.1 women holding hands: medium-light skin tone, medium-dark skin tone";
## 1F469 1F3FC 200D 1F91D 200D 1F469 1F3FF    ; fully-qualified     # 👩🏼‍🤝‍👩🏿 E12.1 women holding hands: medium-light skin tone, dark skin tone # emoji-test.txt line #2632 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FF⟆ 👩🏼‍🤝‍👩🏿 E12.1 women holding hands: medium-light skin tone, dark skin tone";
## 1F469 1F3FD 200D 1F91D 200D 1F469 1F3FB    ; fully-qualified     # 👩🏽‍🤝‍👩🏻 E12.0 women holding hands: medium skin tone, light skin tone # emoji-test.txt line #2633 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FB⟆ 👩🏽‍🤝‍👩🏻 E12.0 women holding hands: medium skin tone, light skin tone";
## 1F469 1F3FD 200D 1F91D 200D 1F469 1F3FC    ; fully-qualified     # 👩🏽‍🤝‍👩🏼 E12.0 women holding hands: medium skin tone, medium-light skin tone # emoji-test.txt line #2634 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FC⟆ 👩🏽‍🤝‍👩🏼 E12.0 women holding hands: medium skin tone, medium-light skin tone";
## 1F46D 1F3FD                                ; fully-qualified     # 👭🏽 E12.0 women holding hands: medium skin tone # emoji-test.txt line #2635 Emoji version 13.0
is Uni.new(0x1F46D, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F46D, 0x1F3FD⟆ 👭🏽 E12.0 women holding hands: medium skin tone";
## 1F469 1F3FD 200D 1F91D 200D 1F469 1F3FE    ; fully-qualified     # 👩🏽‍🤝‍👩🏾 E12.1 women holding hands: medium skin tone, medium-dark skin tone # emoji-test.txt line #2636 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FE⟆ 👩🏽‍🤝‍👩🏾 E12.1 women holding hands: medium skin tone, medium-dark skin tone";
## 1F469 1F3FD 200D 1F91D 200D 1F469 1F3FF    ; fully-qualified     # 👩🏽‍🤝‍👩🏿 E12.1 women holding hands: medium skin tone, dark skin tone # emoji-test.txt line #2637 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FF⟆ 👩🏽‍🤝‍👩🏿 E12.1 women holding hands: medium skin tone, dark skin tone";
## 1F469 1F3FE 200D 1F91D 200D 1F469 1F3FB    ; fully-qualified     # 👩🏾‍🤝‍👩🏻 E12.0 women holding hands: medium-dark skin tone, light skin tone # emoji-test.txt line #2638 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FB⟆ 👩🏾‍🤝‍👩🏻 E12.0 women holding hands: medium-dark skin tone, light skin tone";
## 1F469 1F3FE 200D 1F91D 200D 1F469 1F3FC    ; fully-qualified     # 👩🏾‍🤝‍👩🏼 E12.0 women holding hands: medium-dark skin tone, medium-light skin tone # emoji-test.txt line #2639 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FC⟆ 👩🏾‍🤝‍👩🏼 E12.0 women holding hands: medium-dark skin tone, medium-light skin tone";
## 1F469 1F3FE 200D 1F91D 200D 1F469 1F3FD    ; fully-qualified     # 👩🏾‍🤝‍👩🏽 E12.0 women holding hands: medium-dark skin tone, medium skin tone # emoji-test.txt line #2640 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FD⟆ 👩🏾‍🤝‍👩🏽 E12.0 women holding hands: medium-dark skin tone, medium skin tone";
## 1F46D 1F3FE                                ; fully-qualified     # 👭🏾 E12.0 women holding hands: medium-dark skin tone # emoji-test.txt line #2641 Emoji version 13.0
is Uni.new(0x1F46D, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F46D, 0x1F3FE⟆ 👭🏾 E12.0 women holding hands: medium-dark skin tone";
## 1F469 1F3FE 200D 1F91D 200D 1F469 1F3FF    ; fully-qualified     # 👩🏾‍🤝‍👩🏿 E12.1 women holding hands: medium-dark skin tone, dark skin tone # emoji-test.txt line #2642 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FF⟆ 👩🏾‍🤝‍👩🏿 E12.1 women holding hands: medium-dark skin tone, dark skin tone";
## 1F469 1F3FF 200D 1F91D 200D 1F469 1F3FB    ; fully-qualified     # 👩🏿‍🤝‍👩🏻 E12.0 women holding hands: dark skin tone, light skin tone # emoji-test.txt line #2643 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FB⟆ 👩🏿‍🤝‍👩🏻 E12.0 women holding hands: dark skin tone, light skin tone";
## 1F469 1F3FF 200D 1F91D 200D 1F469 1F3FC    ; fully-qualified     # 👩🏿‍🤝‍👩🏼 E12.0 women holding hands: dark skin tone, medium-light skin tone # emoji-test.txt line #2644 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FC⟆ 👩🏿‍🤝‍👩🏼 E12.0 women holding hands: dark skin tone, medium-light skin tone";
## 1F469 1F3FF 200D 1F91D 200D 1F469 1F3FD    ; fully-qualified     # 👩🏿‍🤝‍👩🏽 E12.0 women holding hands: dark skin tone, medium skin tone # emoji-test.txt line #2645 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FD⟆ 👩🏿‍🤝‍👩🏽 E12.0 women holding hands: dark skin tone, medium skin tone";
## 1F469 1F3FF 200D 1F91D 200D 1F469 1F3FE    ; fully-qualified     # 👩🏿‍🤝‍👩🏾 E12.0 women holding hands: dark skin tone, medium-dark skin tone # emoji-test.txt line #2646 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F469, 0x1F3FE⟆ 👩🏿‍🤝‍👩🏾 E12.0 women holding hands: dark skin tone, medium-dark skin tone";
## 1F46D 1F3FF                                ; fully-qualified     # 👭🏿 E12.0 women holding hands: dark skin tone # emoji-test.txt line #2647 Emoji version 13.0
is Uni.new(0x1F46D, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F46D, 0x1F3FF⟆ 👭🏿 E12.0 women holding hands: dark skin tone";
## 1F46B 1F3FB                                ; fully-qualified     # 👫🏻 E12.0 woman and man holding hands: light skin tone # emoji-test.txt line #2649 Emoji version 13.0
is Uni.new(0x1F46B, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F46B, 0x1F3FB⟆ 👫🏻 E12.0 woman and man holding hands: light skin tone";
## 1F469 1F3FB 200D 1F91D 200D 1F468 1F3FC    ; fully-qualified     # 👩🏻‍🤝‍👨🏼 E12.0 woman and man holding hands: light skin tone, medium-light skin tone # emoji-test.txt line #2650 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC⟆ 👩🏻‍🤝‍👨🏼 E12.0 woman and man holding hands: light skin tone, medium-light skin tone";
## 1F469 1F3FB 200D 1F91D 200D 1F468 1F3FD    ; fully-qualified     # 👩🏻‍🤝‍👨🏽 E12.0 woman and man holding hands: light skin tone, medium skin tone # emoji-test.txt line #2651 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD⟆ 👩🏻‍🤝‍👨🏽 E12.0 woman and man holding hands: light skin tone, medium skin tone";
## 1F469 1F3FB 200D 1F91D 200D 1F468 1F3FE    ; fully-qualified     # 👩🏻‍🤝‍👨🏾 E12.0 woman and man holding hands: light skin tone, medium-dark skin tone # emoji-test.txt line #2652 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE⟆ 👩🏻‍🤝‍👨🏾 E12.0 woman and man holding hands: light skin tone, medium-dark skin tone";
## 1F469 1F3FB 200D 1F91D 200D 1F468 1F3FF    ; fully-qualified     # 👩🏻‍🤝‍👨🏿 E12.0 woman and man holding hands: light skin tone, dark skin tone # emoji-test.txt line #2653 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF⟆ 👩🏻‍🤝‍👨🏿 E12.0 woman and man holding hands: light skin tone, dark skin tone";
## 1F469 1F3FC 200D 1F91D 200D 1F468 1F3FB    ; fully-qualified     # 👩🏼‍🤝‍👨🏻 E12.0 woman and man holding hands: medium-light skin tone, light skin tone # emoji-test.txt line #2654 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB⟆ 👩🏼‍🤝‍👨🏻 E12.0 woman and man holding hands: medium-light skin tone, light skin tone";
## 1F46B 1F3FC                                ; fully-qualified     # 👫🏼 E12.0 woman and man holding hands: medium-light skin tone # emoji-test.txt line #2655 Emoji version 13.0
is Uni.new(0x1F46B, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F46B, 0x1F3FC⟆ 👫🏼 E12.0 woman and man holding hands: medium-light skin tone";
## 1F469 1F3FC 200D 1F91D 200D 1F468 1F3FD    ; fully-qualified     # 👩🏼‍🤝‍👨🏽 E12.0 woman and man holding hands: medium-light skin tone, medium skin tone # emoji-test.txt line #2656 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD⟆ 👩🏼‍🤝‍👨🏽 E12.0 woman and man holding hands: medium-light skin tone, medium skin tone";
## 1F469 1F3FC 200D 1F91D 200D 1F468 1F3FE    ; fully-qualified     # 👩🏼‍🤝‍👨🏾 E12.0 woman and man holding hands: medium-light skin tone, medium-dark skin tone # emoji-test.txt line #2657 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE⟆ 👩🏼‍🤝‍👨🏾 E12.0 woman and man holding hands: medium-light skin tone, medium-dark skin tone";
## 1F469 1F3FC 200D 1F91D 200D 1F468 1F3FF    ; fully-qualified     # 👩🏼‍🤝‍👨🏿 E12.0 woman and man holding hands: medium-light skin tone, dark skin tone # emoji-test.txt line #2658 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF⟆ 👩🏼‍🤝‍👨🏿 E12.0 woman and man holding hands: medium-light skin tone, dark skin tone";
## 1F469 1F3FD 200D 1F91D 200D 1F468 1F3FB    ; fully-qualified     # 👩🏽‍🤝‍👨🏻 E12.0 woman and man holding hands: medium skin tone, light skin tone # emoji-test.txt line #2659 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB⟆ 👩🏽‍🤝‍👨🏻 E12.0 woman and man holding hands: medium skin tone, light skin tone";
## 1F469 1F3FD 200D 1F91D 200D 1F468 1F3FC    ; fully-qualified     # 👩🏽‍🤝‍👨🏼 E12.0 woman and man holding hands: medium skin tone, medium-light skin tone # emoji-test.txt line #2660 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC⟆ 👩🏽‍🤝‍👨🏼 E12.0 woman and man holding hands: medium skin tone, medium-light skin tone";
## 1F46B 1F3FD                                ; fully-qualified     # 👫🏽 E12.0 woman and man holding hands: medium skin tone # emoji-test.txt line #2661 Emoji version 13.0
is Uni.new(0x1F46B, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F46B, 0x1F3FD⟆ 👫🏽 E12.0 woman and man holding hands: medium skin tone";
## 1F469 1F3FD 200D 1F91D 200D 1F468 1F3FE    ; fully-qualified     # 👩🏽‍🤝‍👨🏾 E12.0 woman and man holding hands: medium skin tone, medium-dark skin tone # emoji-test.txt line #2662 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE⟆ 👩🏽‍🤝‍👨🏾 E12.0 woman and man holding hands: medium skin tone, medium-dark skin tone";
## 1F469 1F3FD 200D 1F91D 200D 1F468 1F3FF    ; fully-qualified     # 👩🏽‍🤝‍👨🏿 E12.0 woman and man holding hands: medium skin tone, dark skin tone # emoji-test.txt line #2663 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF⟆ 👩🏽‍🤝‍👨🏿 E12.0 woman and man holding hands: medium skin tone, dark skin tone";
## 1F469 1F3FE 200D 1F91D 200D 1F468 1F3FB    ; fully-qualified     # 👩🏾‍🤝‍👨🏻 E12.0 woman and man holding hands: medium-dark skin tone, light skin tone # emoji-test.txt line #2664 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB⟆ 👩🏾‍🤝‍👨🏻 E12.0 woman and man holding hands: medium-dark skin tone, light skin tone";
## 1F469 1F3FE 200D 1F91D 200D 1F468 1F3FC    ; fully-qualified     # 👩🏾‍🤝‍👨🏼 E12.0 woman and man holding hands: medium-dark skin tone, medium-light skin tone # emoji-test.txt line #2665 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC⟆ 👩🏾‍🤝‍👨🏼 E12.0 woman and man holding hands: medium-dark skin tone, medium-light skin tone";
## 1F469 1F3FE 200D 1F91D 200D 1F468 1F3FD    ; fully-qualified     # 👩🏾‍🤝‍👨🏽 E12.0 woman and man holding hands: medium-dark skin tone, medium skin tone # emoji-test.txt line #2666 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD⟆ 👩🏾‍🤝‍👨🏽 E12.0 woman and man holding hands: medium-dark skin tone, medium skin tone";
## 1F46B 1F3FE                                ; fully-qualified     # 👫🏾 E12.0 woman and man holding hands: medium-dark skin tone # emoji-test.txt line #2667 Emoji version 13.0
is Uni.new(0x1F46B, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F46B, 0x1F3FE⟆ 👫🏾 E12.0 woman and man holding hands: medium-dark skin tone";
## 1F469 1F3FE 200D 1F91D 200D 1F468 1F3FF    ; fully-qualified     # 👩🏾‍🤝‍👨🏿 E12.0 woman and man holding hands: medium-dark skin tone, dark skin tone # emoji-test.txt line #2668 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF⟆ 👩🏾‍🤝‍👨🏿 E12.0 woman and man holding hands: medium-dark skin tone, dark skin tone";
## 1F469 1F3FF 200D 1F91D 200D 1F468 1F3FB    ; fully-qualified     # 👩🏿‍🤝‍👨🏻 E12.0 woman and man holding hands: dark skin tone, light skin tone # emoji-test.txt line #2669 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB⟆ 👩🏿‍🤝‍👨🏻 E12.0 woman and man holding hands: dark skin tone, light skin tone";
## 1F469 1F3FF 200D 1F91D 200D 1F468 1F3FC    ; fully-qualified     # 👩🏿‍🤝‍👨🏼 E12.0 woman and man holding hands: dark skin tone, medium-light skin tone # emoji-test.txt line #2670 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC⟆ 👩🏿‍🤝‍👨🏼 E12.0 woman and man holding hands: dark skin tone, medium-light skin tone";
## 1F469 1F3FF 200D 1F91D 200D 1F468 1F3FD    ; fully-qualified     # 👩🏿‍🤝‍👨🏽 E12.0 woman and man holding hands: dark skin tone, medium skin tone # emoji-test.txt line #2671 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD⟆ 👩🏿‍🤝‍👨🏽 E12.0 woman and man holding hands: dark skin tone, medium skin tone";
## 1F469 1F3FF 200D 1F91D 200D 1F468 1F3FE    ; fully-qualified     # 👩🏿‍🤝‍👨🏾 E12.0 woman and man holding hands: dark skin tone, medium-dark skin tone # emoji-test.txt line #2672 Emoji version 13.0
is Uni.new(0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F469, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE⟆ 👩🏿‍🤝‍👨🏾 E12.0 woman and man holding hands: dark skin tone, medium-dark skin tone";
## 1F46B 1F3FF                                ; fully-qualified     # 👫🏿 E12.0 woman and man holding hands: dark skin tone # emoji-test.txt line #2673 Emoji version 13.0
is Uni.new(0x1F46B, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F46B, 0x1F3FF⟆ 👫🏿 E12.0 woman and man holding hands: dark skin tone";
## 1F46C 1F3FB                                ; fully-qualified     # 👬🏻 E12.0 men holding hands: light skin tone # emoji-test.txt line #2675 Emoji version 13.0
is Uni.new(0x1F46C, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F46C, 0x1F3FB⟆ 👬🏻 E12.0 men holding hands: light skin tone";
## 1F468 1F3FB 200D 1F91D 200D 1F468 1F3FC    ; fully-qualified     # 👨🏻‍🤝‍👨🏼 E12.1 men holding hands: light skin tone, medium-light skin tone # emoji-test.txt line #2676 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC⟆ 👨🏻‍🤝‍👨🏼 E12.1 men holding hands: light skin tone, medium-light skin tone";
## 1F468 1F3FB 200D 1F91D 200D 1F468 1F3FD    ; fully-qualified     # 👨🏻‍🤝‍👨🏽 E12.1 men holding hands: light skin tone, medium skin tone # emoji-test.txt line #2677 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD⟆ 👨🏻‍🤝‍👨🏽 E12.1 men holding hands: light skin tone, medium skin tone";
## 1F468 1F3FB 200D 1F91D 200D 1F468 1F3FE    ; fully-qualified     # 👨🏻‍🤝‍👨🏾 E12.1 men holding hands: light skin tone, medium-dark skin tone # emoji-test.txt line #2678 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE⟆ 👨🏻‍🤝‍👨🏾 E12.1 men holding hands: light skin tone, medium-dark skin tone";
## 1F468 1F3FB 200D 1F91D 200D 1F468 1F3FF    ; fully-qualified     # 👨🏻‍🤝‍👨🏿 E12.1 men holding hands: light skin tone, dark skin tone # emoji-test.txt line #2679 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FB, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF⟆ 👨🏻‍🤝‍👨🏿 E12.1 men holding hands: light skin tone, dark skin tone";
## 1F468 1F3FC 200D 1F91D 200D 1F468 1F3FB    ; fully-qualified     # 👨🏼‍🤝‍👨🏻 E12.0 men holding hands: medium-light skin tone, light skin tone # emoji-test.txt line #2680 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB⟆ 👨🏼‍🤝‍👨🏻 E12.0 men holding hands: medium-light skin tone, light skin tone";
## 1F46C 1F3FC                                ; fully-qualified     # 👬🏼 E12.0 men holding hands: medium-light skin tone # emoji-test.txt line #2681 Emoji version 13.0
is Uni.new(0x1F46C, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F46C, 0x1F3FC⟆ 👬🏼 E12.0 men holding hands: medium-light skin tone";
## 1F468 1F3FC 200D 1F91D 200D 1F468 1F3FD    ; fully-qualified     # 👨🏼‍🤝‍👨🏽 E12.1 men holding hands: medium-light skin tone, medium skin tone # emoji-test.txt line #2682 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD⟆ 👨🏼‍🤝‍👨🏽 E12.1 men holding hands: medium-light skin tone, medium skin tone";
## 1F468 1F3FC 200D 1F91D 200D 1F468 1F3FE    ; fully-qualified     # 👨🏼‍🤝‍👨🏾 E12.1 men holding hands: medium-light skin tone, medium-dark skin tone # emoji-test.txt line #2683 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE⟆ 👨🏼‍🤝‍👨🏾 E12.1 men holding hands: medium-light skin tone, medium-dark skin tone";
## 1F468 1F3FC 200D 1F91D 200D 1F468 1F3FF    ; fully-qualified     # 👨🏼‍🤝‍👨🏿 E12.1 men holding hands: medium-light skin tone, dark skin tone # emoji-test.txt line #2684 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FC, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF⟆ 👨🏼‍🤝‍👨🏿 E12.1 men holding hands: medium-light skin tone, dark skin tone";
## 1F468 1F3FD 200D 1F91D 200D 1F468 1F3FB    ; fully-qualified     # 👨🏽‍🤝‍👨🏻 E12.0 men holding hands: medium skin tone, light skin tone # emoji-test.txt line #2685 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB⟆ 👨🏽‍🤝‍👨🏻 E12.0 men holding hands: medium skin tone, light skin tone";
## 1F468 1F3FD 200D 1F91D 200D 1F468 1F3FC    ; fully-qualified     # 👨🏽‍🤝‍👨🏼 E12.0 men holding hands: medium skin tone, medium-light skin tone # emoji-test.txt line #2686 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC⟆ 👨🏽‍🤝‍👨🏼 E12.0 men holding hands: medium skin tone, medium-light skin tone";
## 1F46C 1F3FD                                ; fully-qualified     # 👬🏽 E12.0 men holding hands: medium skin tone # emoji-test.txt line #2687 Emoji version 13.0
is Uni.new(0x1F46C, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F46C, 0x1F3FD⟆ 👬🏽 E12.0 men holding hands: medium skin tone";
## 1F468 1F3FD 200D 1F91D 200D 1F468 1F3FE    ; fully-qualified     # 👨🏽‍🤝‍👨🏾 E12.1 men holding hands: medium skin tone, medium-dark skin tone # emoji-test.txt line #2688 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE⟆ 👨🏽‍🤝‍👨🏾 E12.1 men holding hands: medium skin tone, medium-dark skin tone";
## 1F468 1F3FD 200D 1F91D 200D 1F468 1F3FF    ; fully-qualified     # 👨🏽‍🤝‍👨🏿 E12.1 men holding hands: medium skin tone, dark skin tone # emoji-test.txt line #2689 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FD, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF⟆ 👨🏽‍🤝‍👨🏿 E12.1 men holding hands: medium skin tone, dark skin tone";
## 1F468 1F3FE 200D 1F91D 200D 1F468 1F3FB    ; fully-qualified     # 👨🏾‍🤝‍👨🏻 E12.0 men holding hands: medium-dark skin tone, light skin tone # emoji-test.txt line #2690 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB⟆ 👨🏾‍🤝‍👨🏻 E12.0 men holding hands: medium-dark skin tone, light skin tone";
## 1F468 1F3FE 200D 1F91D 200D 1F468 1F3FC    ; fully-qualified     # 👨🏾‍🤝‍👨🏼 E12.0 men holding hands: medium-dark skin tone, medium-light skin tone # emoji-test.txt line #2691 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC⟆ 👨🏾‍🤝‍👨🏼 E12.0 men holding hands: medium-dark skin tone, medium-light skin tone";
## 1F468 1F3FE 200D 1F91D 200D 1F468 1F3FD    ; fully-qualified     # 👨🏾‍🤝‍👨🏽 E12.0 men holding hands: medium-dark skin tone, medium skin tone # emoji-test.txt line #2692 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD⟆ 👨🏾‍🤝‍👨🏽 E12.0 men holding hands: medium-dark skin tone, medium skin tone";
## 1F46C 1F3FE                                ; fully-qualified     # 👬🏾 E12.0 men holding hands: medium-dark skin tone # emoji-test.txt line #2693 Emoji version 13.0
is Uni.new(0x1F46C, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F46C, 0x1F3FE⟆ 👬🏾 E12.0 men holding hands: medium-dark skin tone";
## 1F468 1F3FE 200D 1F91D 200D 1F468 1F3FF    ; fully-qualified     # 👨🏾‍🤝‍👨🏿 E12.1 men holding hands: medium-dark skin tone, dark skin tone # emoji-test.txt line #2694 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FE, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FF⟆ 👨🏾‍🤝‍👨🏿 E12.1 men holding hands: medium-dark skin tone, dark skin tone";
## 1F468 1F3FF 200D 1F91D 200D 1F468 1F3FB    ; fully-qualified     # 👨🏿‍🤝‍👨🏻 E12.0 men holding hands: dark skin tone, light skin tone # emoji-test.txt line #2695 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FB⟆ 👨🏿‍🤝‍👨🏻 E12.0 men holding hands: dark skin tone, light skin tone";
## 1F468 1F3FF 200D 1F91D 200D 1F468 1F3FC    ; fully-qualified     # 👨🏿‍🤝‍👨🏼 E12.0 men holding hands: dark skin tone, medium-light skin tone # emoji-test.txt line #2696 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FC⟆ 👨🏿‍🤝‍👨🏼 E12.0 men holding hands: dark skin tone, medium-light skin tone";
## 1F468 1F3FF 200D 1F91D 200D 1F468 1F3FD    ; fully-qualified     # 👨🏿‍🤝‍👨🏽 E12.0 men holding hands: dark skin tone, medium skin tone # emoji-test.txt line #2697 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FD⟆ 👨🏿‍🤝‍👨🏽 E12.0 men holding hands: dark skin tone, medium skin tone";
## 1F468 1F3FF 200D 1F91D 200D 1F468 1F3FE    ; fully-qualified     # 👨🏿‍🤝‍👨🏾 E12.0 men holding hands: dark skin tone, medium-dark skin tone # emoji-test.txt line #2698 Emoji version 13.0
is Uni.new(0x1F468, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE).Str.chars, 1, "Codes: ⟅0x1F468, 0x1F3FF, 0x200D, 0x1F91D, 0x200D, 0x1F468, 0x1F3FE⟆ 👨🏿‍🤝‍👨🏾 E12.0 men holding hands: dark skin tone, medium-dark skin tone";
## 1F46C 1F3FF                                ; fully-qualified     # 👬🏿 E12.0 men holding hands: dark skin tone # emoji-test.txt line #2699 Emoji version 13.0
is Uni.new(0x1F46C, 0x1F3FF).Str.chars, 1, "Codes: ⟅0x1F46C, 0x1F3FF⟆ 👬🏿 E12.0 men holding hands: dark skin tone";
## 1F469 200D 2764 FE0F 200D 1F48B 200D 1F468 ; fully-qualified     # 👩‍❤️‍💋‍👨 E2.0 kiss: woman, man # emoji-test.txt line #2701 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F48B, 0x200D, 0x1F468).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F48B, 0x200D, 0x1F468⟆ 👩‍❤️‍💋‍👨 E2.0 kiss: woman, man";
## 1F469 200D 2764 200D 1F48B 200D 1F468      ; minimally-qualified # 👩‍❤‍💋‍👨 E2.0 kiss: woman, man # emoji-test.txt line #2702 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2764, 0x200D, 0x1F48B, 0x200D, 0x1F468).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2764, 0x200D, 0x1F48B, 0x200D, 0x1F468⟆ 👩‍❤‍💋‍👨 E2.0 kiss: woman, man";
## 1F468 200D 2764 FE0F 200D 1F48B 200D 1F468 ; fully-qualified     # 👨‍❤️‍💋‍👨 E2.0 kiss: man, man # emoji-test.txt line #2703 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F48B, 0x200D, 0x1F468).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F48B, 0x200D, 0x1F468⟆ 👨‍❤️‍💋‍👨 E2.0 kiss: man, man";
## 1F468 200D 2764 200D 1F48B 200D 1F468      ; minimally-qualified # 👨‍❤‍💋‍👨 E2.0 kiss: man, man # emoji-test.txt line #2704 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x2764, 0x200D, 0x1F48B, 0x200D, 0x1F468).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x2764, 0x200D, 0x1F48B, 0x200D, 0x1F468⟆ 👨‍❤‍💋‍👨 E2.0 kiss: man, man";
## 1F469 200D 2764 FE0F 200D 1F48B 200D 1F469 ; fully-qualified     # 👩‍❤️‍💋‍👩 E2.0 kiss: woman, woman # emoji-test.txt line #2705 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F48B, 0x200D, 0x1F469).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F48B, 0x200D, 0x1F469⟆ 👩‍❤️‍💋‍👩 E2.0 kiss: woman, woman";
## 1F469 200D 2764 200D 1F48B 200D 1F469      ; minimally-qualified # 👩‍❤‍💋‍👩 E2.0 kiss: woman, woman # emoji-test.txt line #2706 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2764, 0x200D, 0x1F48B, 0x200D, 0x1F469).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2764, 0x200D, 0x1F48B, 0x200D, 0x1F469⟆ 👩‍❤‍💋‍👩 E2.0 kiss: woman, woman";
## 1F469 200D 2764 FE0F 200D 1F468            ; fully-qualified     # 👩‍❤️‍👨 E2.0 couple with heart: woman, man # emoji-test.txt line #2708 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F468).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F468⟆ 👩‍❤️‍👨 E2.0 couple with heart: woman, man";
## 1F469 200D 2764 200D 1F468                 ; minimally-qualified # 👩‍❤‍👨 E2.0 couple with heart: woman, man # emoji-test.txt line #2709 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2764, 0x200D, 0x1F468).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2764, 0x200D, 0x1F468⟆ 👩‍❤‍👨 E2.0 couple with heart: woman, man";
## 1F468 200D 2764 FE0F 200D 1F468            ; fully-qualified     # 👨‍❤️‍👨 E2.0 couple with heart: man, man # emoji-test.txt line #2710 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F468).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F468⟆ 👨‍❤️‍👨 E2.0 couple with heart: man, man";
## 1F468 200D 2764 200D 1F468                 ; minimally-qualified # 👨‍❤‍👨 E2.0 couple with heart: man, man # emoji-test.txt line #2711 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x2764, 0x200D, 0x1F468).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x2764, 0x200D, 0x1F468⟆ 👨‍❤‍👨 E2.0 couple with heart: man, man";
## 1F469 200D 2764 FE0F 200D 1F469            ; fully-qualified     # 👩‍❤️‍👩 E2.0 couple with heart: woman, woman # emoji-test.txt line #2712 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F469).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2764, 0xFE0F, 0x200D, 0x1F469⟆ 👩‍❤️‍👩 E2.0 couple with heart: woman, woman";
## 1F469 200D 2764 200D 1F469                 ; minimally-qualified # 👩‍❤‍👩 E2.0 couple with heart: woman, woman # emoji-test.txt line #2713 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x2764, 0x200D, 0x1F469).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x2764, 0x200D, 0x1F469⟆ 👩‍❤‍👩 E2.0 couple with heart: woman, woman";
## 1F468 200D 1F469 200D 1F466                ; fully-qualified     # 👨‍👩‍👦 E2.0 family: man, woman, boy # emoji-test.txt line #2715 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F469, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F469, 0x200D, 0x1F466⟆ 👨‍👩‍👦 E2.0 family: man, woman, boy";
## 1F468 200D 1F469 200D 1F467                ; fully-qualified     # 👨‍👩‍👧 E2.0 family: man, woman, girl # emoji-test.txt line #2716 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F469, 0x200D, 0x1F467).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F469, 0x200D, 0x1F467⟆ 👨‍👩‍👧 E2.0 family: man, woman, girl";
## 1F468 200D 1F469 200D 1F467 200D 1F466     ; fully-qualified     # 👨‍👩‍👧‍👦 E2.0 family: man, woman, girl, boy # emoji-test.txt line #2717 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F466⟆ 👨‍👩‍👧‍👦 E2.0 family: man, woman, girl, boy";
## 1F468 200D 1F469 200D 1F466 200D 1F466     ; fully-qualified     # 👨‍👩‍👦‍👦 E2.0 family: man, woman, boy, boy # emoji-test.txt line #2718 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F469, 0x200D, 0x1F466, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F469, 0x200D, 0x1F466, 0x200D, 0x1F466⟆ 👨‍👩‍👦‍👦 E2.0 family: man, woman, boy, boy";
## 1F468 200D 1F469 200D 1F467 200D 1F467     ; fully-qualified     # 👨‍👩‍👧‍👧 E2.0 family: man, woman, girl, girl # emoji-test.txt line #2719 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F467).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F467⟆ 👨‍👩‍👧‍👧 E2.0 family: man, woman, girl, girl";
## 1F468 200D 1F468 200D 1F466                ; fully-qualified     # 👨‍👨‍👦 E2.0 family: man, man, boy # emoji-test.txt line #2720 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F468, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F468, 0x200D, 0x1F466⟆ 👨‍👨‍👦 E2.0 family: man, man, boy";
## 1F468 200D 1F468 200D 1F467                ; fully-qualified     # 👨‍👨‍👧 E2.0 family: man, man, girl # emoji-test.txt line #2721 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F468, 0x200D, 0x1F467).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F468, 0x200D, 0x1F467⟆ 👨‍👨‍👧 E2.0 family: man, man, girl";
## 1F468 200D 1F468 200D 1F467 200D 1F466     ; fully-qualified     # 👨‍👨‍👧‍👦 E2.0 family: man, man, girl, boy # emoji-test.txt line #2722 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F468, 0x200D, 0x1F467, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F468, 0x200D, 0x1F467, 0x200D, 0x1F466⟆ 👨‍👨‍👧‍👦 E2.0 family: man, man, girl, boy";
## 1F468 200D 1F468 200D 1F466 200D 1F466     ; fully-qualified     # 👨‍👨‍👦‍👦 E2.0 family: man, man, boy, boy # emoji-test.txt line #2723 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F468, 0x200D, 0x1F466, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F468, 0x200D, 0x1F466, 0x200D, 0x1F466⟆ 👨‍👨‍👦‍👦 E2.0 family: man, man, boy, boy";
## 1F468 200D 1F468 200D 1F467 200D 1F467     ; fully-qualified     # 👨‍👨‍👧‍👧 E2.0 family: man, man, girl, girl # emoji-test.txt line #2724 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F468, 0x200D, 0x1F467, 0x200D, 0x1F467).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F468, 0x200D, 0x1F467, 0x200D, 0x1F467⟆ 👨‍👨‍👧‍👧 E2.0 family: man, man, girl, girl";
## 1F469 200D 1F469 200D 1F466                ; fully-qualified     # 👩‍👩‍👦 E2.0 family: woman, woman, boy # emoji-test.txt line #2725 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F469, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F469, 0x200D, 0x1F466⟆ 👩‍👩‍👦 E2.0 family: woman, woman, boy";
## 1F469 200D 1F469 200D 1F467                ; fully-qualified     # 👩‍👩‍👧 E2.0 family: woman, woman, girl # emoji-test.txt line #2726 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F469, 0x200D, 0x1F467).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F469, 0x200D, 0x1F467⟆ 👩‍👩‍👧 E2.0 family: woman, woman, girl";
## 1F469 200D 1F469 200D 1F467 200D 1F466     ; fully-qualified     # 👩‍👩‍👧‍👦 E2.0 family: woman, woman, girl, boy # emoji-test.txt line #2727 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F466⟆ 👩‍👩‍👧‍👦 E2.0 family: woman, woman, girl, boy";
## 1F469 200D 1F469 200D 1F466 200D 1F466     ; fully-qualified     # 👩‍👩‍👦‍👦 E2.0 family: woman, woman, boy, boy # emoji-test.txt line #2728 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F469, 0x200D, 0x1F466, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F469, 0x200D, 0x1F466, 0x200D, 0x1F466⟆ 👩‍👩‍👦‍👦 E2.0 family: woman, woman, boy, boy";
## 1F469 200D 1F469 200D 1F467 200D 1F467     ; fully-qualified     # 👩‍👩‍👧‍👧 E2.0 family: woman, woman, girl, girl # emoji-test.txt line #2729 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F467).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F467⟆ 👩‍👩‍👧‍👧 E2.0 family: woman, woman, girl, girl";
## 1F468 200D 1F466                           ; fully-qualified     # 👨‍👦 E4.0 family: man, boy # emoji-test.txt line #2730 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F466⟆ 👨‍👦 E4.0 family: man, boy";
## 1F468 200D 1F466 200D 1F466                ; fully-qualified     # 👨‍👦‍👦 E4.0 family: man, boy, boy # emoji-test.txt line #2731 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F466, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F466, 0x200D, 0x1F466⟆ 👨‍👦‍👦 E4.0 family: man, boy, boy";
## 1F468 200D 1F467                           ; fully-qualified     # 👨‍👧 E4.0 family: man, girl # emoji-test.txt line #2732 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F467).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F467⟆ 👨‍👧 E4.0 family: man, girl";
## 1F468 200D 1F467 200D 1F466                ; fully-qualified     # 👨‍👧‍👦 E4.0 family: man, girl, boy # emoji-test.txt line #2733 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F467, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F467, 0x200D, 0x1F466⟆ 👨‍👧‍👦 E4.0 family: man, girl, boy";
## 1F468 200D 1F467 200D 1F467                ; fully-qualified     # 👨‍👧‍👧 E4.0 family: man, girl, girl # emoji-test.txt line #2734 Emoji version 13.0
is Uni.new(0x1F468, 0x200D, 0x1F467, 0x200D, 0x1F467).Str.chars, 1, "Codes: ⟅0x1F468, 0x200D, 0x1F467, 0x200D, 0x1F467⟆ 👨‍👧‍👧 E4.0 family: man, girl, girl";
## 1F469 200D 1F466                           ; fully-qualified     # 👩‍👦 E4.0 family: woman, boy # emoji-test.txt line #2735 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F466⟆ 👩‍👦 E4.0 family: woman, boy";
## 1F469 200D 1F466 200D 1F466                ; fully-qualified     # 👩‍👦‍👦 E4.0 family: woman, boy, boy # emoji-test.txt line #2736 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F466, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F466, 0x200D, 0x1F466⟆ 👩‍👦‍👦 E4.0 family: woman, boy, boy";
## 1F469 200D 1F467                           ; fully-qualified     # 👩‍👧 E4.0 family: woman, girl # emoji-test.txt line #2737 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F467).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F467⟆ 👩‍👧 E4.0 family: woman, girl";
## 1F469 200D 1F467 200D 1F466                ; fully-qualified     # 👩‍👧‍👦 E4.0 family: woman, girl, boy # emoji-test.txt line #2738 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F466).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F466⟆ 👩‍👧‍👦 E4.0 family: woman, girl, boy";
## 1F469 200D 1F467 200D 1F467                ; fully-qualified     # 👩‍👧‍👧 E4.0 family: woman, girl, girl # emoji-test.txt line #2739 Emoji version 13.0
is Uni.new(0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F467).Str.chars, 1, "Codes: ⟅0x1F469, 0x200D, 0x1F467, 0x200D, 0x1F467⟆ 👩‍👧‍👧 E4.0 family: woman, girl, girl";
## 1F5E3 FE0F                                 ; fully-qualified     # 🗣️ E0.7 speaking head # emoji-test.txt line #2742 Emoji version 13.0
is Uni.new(0x1F5E3, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5E3, 0xFE0F⟆ 🗣️ E0.7 speaking head";
## 1F415 200D 1F9BA                           ; fully-qualified     # 🐕‍🦺 E12.0 service dog # emoji-test.txt line #2780 Emoji version 13.0
is Uni.new(0x1F415, 0x200D, 0x1F9BA).Str.chars, 1, "Codes: ⟅0x1F415, 0x200D, 0x1F9BA⟆ 🐕‍🦺 E12.0 service dog";
## 1F408 200D 2B1B                            ; fully-qualified     # 🐈‍⬛ E13.0 black cat # emoji-test.txt line #2787 Emoji version 13.0
is Uni.new(0x1F408, 0x200D, 0x2B1B).Str.chars, 1, "Codes: ⟅0x1F408, 0x200D, 0x2B1B⟆ 🐈‍⬛ E13.0 black cat";
## 1F43F FE0F                                 ; fully-qualified     # 🐿️ E0.7 chipmunk # emoji-test.txt line #2823 Emoji version 13.0
is Uni.new(0x1F43F, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F43F, 0xFE0F⟆ 🐿️ E0.7 chipmunk";
## 1F43B 200D 2744 FE0F                       ; fully-qualified     # 🐻‍❄️ E13.0 polar bear # emoji-test.txt line #2829 Emoji version 13.0
is Uni.new(0x1F43B, 0x200D, 0x2744, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F43B, 0x200D, 0x2744, 0xFE0F⟆ 🐻‍❄️ E13.0 polar bear";
## 1F43B 200D 2744                            ; minimally-qualified # 🐻‍❄ E13.0 polar bear # emoji-test.txt line #2830 Emoji version 13.0
is Uni.new(0x1F43B, 0x200D, 0x2744).Str.chars, 1, "Codes: ⟅0x1F43B, 0x200D, 0x2744⟆ 🐻‍❄ E13.0 polar bear";
## 1F54A FE0F                                 ; fully-qualified     # 🕊️ E0.7 dove # emoji-test.txt line #2849 Emoji version 13.0
is Uni.new(0x1F54A, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F54A, 0xFE0F⟆ 🕊️ E0.7 dove";
## 1F577 FE0F                                 ; fully-qualified     # 🕷️ E0.7 spider # emoji-test.txt line #2896 Emoji version 13.0
is Uni.new(0x1F577, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F577, 0xFE0F⟆ 🕷️ E0.7 spider";
## 1F578 FE0F                                 ; fully-qualified     # 🕸️ E0.7 spider web # emoji-test.txt line #2898 Emoji version 13.0
is Uni.new(0x1F578, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F578, 0xFE0F⟆ 🕸️ E0.7 spider web";
## 1F3F5 FE0F                                 ; fully-qualified     # 🏵️ E0.7 rosette # emoji-test.txt line #2910 Emoji version 13.0
is Uni.new(0x1F3F5, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3F5, 0xFE0F⟆ 🏵️ E0.7 rosette";
## 2618 FE0F                                  ; fully-qualified     # ☘️ E1.0 shamrock # emoji-test.txt line #2928 Emoji version 13.0
is Uni.new(0x2618, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2618, 0xFE0F⟆ ☘️ E1.0 shamrock";
## 1F336 FE0F                                 ; fully-qualified     # 🌶️ E0.7 hot pepper # emoji-test.txt line #2967 Emoji version 13.0
is Uni.new(0x1F336, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F336, 0xFE0F⟆ 🌶️ E0.7 hot pepper";
## 1F37D FE0F                                 ; fully-qualified     # 🍽️ E0.7 fork and knife with plate # emoji-test.txt line #3080 Emoji version 13.0
is Uni.new(0x1F37D, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F37D, 0xFE0F⟆ 🍽️ E0.7 fork and knife with plate";
## 1F5FA FE0F                                 ; fully-qualified     # 🗺️ E0.7 world map # emoji-test.txt line #3097 Emoji version 13.0
is Uni.new(0x1F5FA, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5FA, 0xFE0F⟆ 🗺️ E0.7 world map";
## 1F3D4 FE0F                                 ; fully-qualified     # 🏔️ E0.7 snow-capped mountain # emoji-test.txt line #3103 Emoji version 13.0
is Uni.new(0x1F3D4, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3D4, 0xFE0F⟆ 🏔️ E0.7 snow-capped mountain";
## 26F0 FE0F                                  ; fully-qualified     # ⛰️ E0.7 mountain # emoji-test.txt line #3105 Emoji version 13.0
is Uni.new(0x26F0, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F0, 0xFE0F⟆ ⛰️ E0.7 mountain";
## 1F3D5 FE0F                                 ; fully-qualified     # 🏕️ E0.7 camping # emoji-test.txt line #3109 Emoji version 13.0
is Uni.new(0x1F3D5, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3D5, 0xFE0F⟆ 🏕️ E0.7 camping";
## 1F3D6 FE0F                                 ; fully-qualified     # 🏖️ E0.7 beach with umbrella # emoji-test.txt line #3111 Emoji version 13.0
is Uni.new(0x1F3D6, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3D6, 0xFE0F⟆ 🏖️ E0.7 beach with umbrella";
## 1F3DC FE0F                                 ; fully-qualified     # 🏜️ E0.7 desert # emoji-test.txt line #3113 Emoji version 13.0
is Uni.new(0x1F3DC, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3DC, 0xFE0F⟆ 🏜️ E0.7 desert";
## 1F3DD FE0F                                 ; fully-qualified     # 🏝️ E0.7 desert island # emoji-test.txt line #3115 Emoji version 13.0
is Uni.new(0x1F3DD, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3DD, 0xFE0F⟆ 🏝️ E0.7 desert island";
## 1F3DE FE0F                                 ; fully-qualified     # 🏞️ E0.7 national park # emoji-test.txt line #3117 Emoji version 13.0
is Uni.new(0x1F3DE, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3DE, 0xFE0F⟆ 🏞️ E0.7 national park";
## 1F3DF FE0F                                 ; fully-qualified     # 🏟️ E0.7 stadium # emoji-test.txt line #3121 Emoji version 13.0
is Uni.new(0x1F3DF, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3DF, 0xFE0F⟆ 🏟️ E0.7 stadium";
## 1F3DB FE0F                                 ; fully-qualified     # 🏛️ E0.7 classical building # emoji-test.txt line #3123 Emoji version 13.0
is Uni.new(0x1F3DB, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3DB, 0xFE0F⟆ 🏛️ E0.7 classical building";
## 1F3D7 FE0F                                 ; fully-qualified     # 🏗️ E0.7 building construction # emoji-test.txt line #3125 Emoji version 13.0
is Uni.new(0x1F3D7, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3D7, 0xFE0F⟆ 🏗️ E0.7 building construction";
## 1F3D8 FE0F                                 ; fully-qualified     # 🏘️ E0.7 houses # emoji-test.txt line #3131 Emoji version 13.0
is Uni.new(0x1F3D8, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3D8, 0xFE0F⟆ 🏘️ E0.7 houses";
## 1F3DA FE0F                                 ; fully-qualified     # 🏚️ E0.7 derelict house # emoji-test.txt line #3133 Emoji version 13.0
is Uni.new(0x1F3DA, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3DA, 0xFE0F⟆ 🏚️ E0.7 derelict house";
## 26E9 FE0F                                  ; fully-qualified     # ⛩️ E0.7 shinto shrine # emoji-test.txt line #3159 Emoji version 13.0
is Uni.new(0x26E9, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26E9, 0xFE0F⟆ ⛩️ E0.7 shinto shrine";
## 1F3D9 FE0F                                 ; fully-qualified     # 🏙️ E0.7 cityscape # emoji-test.txt line #3168 Emoji version 13.0
is Uni.new(0x1F3D9, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3D9, 0xFE0F⟆ 🏙️ E0.7 cityscape";
## 2668 FE0F                                  ; fully-qualified     # ♨️ E0.6 hot springs # emoji-test.txt line #3175 Emoji version 13.0
is Uni.new(0x2668, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2668, 0xFE0F⟆ ♨️ E0.6 hot springs";
## 1F3CE FE0F                                 ; fully-qualified     # 🏎️ E0.7 racing car # emoji-test.txt line #3213 Emoji version 13.0
is Uni.new(0x1F3CE, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CE, 0xFE0F⟆ 🏎️ E0.7 racing car";
## 1F3CD FE0F                                 ; fully-qualified     # 🏍️ E0.7 motorcycle # emoji-test.txt line #3215 Emoji version 13.0
is Uni.new(0x1F3CD, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3CD, 0xFE0F⟆ 🏍️ E0.7 motorcycle";
## 1F6E3 FE0F                                 ; fully-qualified     # 🛣️ E0.7 motorway # emoji-test.txt line #3226 Emoji version 13.0
is Uni.new(0x1F6E3, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6E3, 0xFE0F⟆ 🛣️ E0.7 motorway";
## 1F6E4 FE0F                                 ; fully-qualified     # 🛤️ E0.7 railway track # emoji-test.txt line #3228 Emoji version 13.0
is Uni.new(0x1F6E4, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6E4, 0xFE0F⟆ 🛤️ E0.7 railway track";
## 1F6E2 FE0F                                 ; fully-qualified     # 🛢️ E0.7 oil drum # emoji-test.txt line #3230 Emoji version 13.0
is Uni.new(0x1F6E2, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6E2, 0xFE0F⟆ 🛢️ E0.7 oil drum";
## 1F6F3 FE0F                                 ; fully-qualified     # 🛳️ E0.7 passenger ship # emoji-test.txt line #3244 Emoji version 13.0
is Uni.new(0x1F6F3, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6F3, 0xFE0F⟆ 🛳️ E0.7 passenger ship";
## 26F4 FE0F                                  ; fully-qualified     # ⛴️ E0.7 ferry # emoji-test.txt line #3246 Emoji version 13.0
is Uni.new(0x26F4, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F4, 0xFE0F⟆ ⛴️ E0.7 ferry";
## 1F6E5 FE0F                                 ; fully-qualified     # 🛥️ E0.7 motor boat # emoji-test.txt line #3248 Emoji version 13.0
is Uni.new(0x1F6E5, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6E5, 0xFE0F⟆ 🛥️ E0.7 motor boat";
## 2708 FE0F                                  ; fully-qualified     # ✈️ E0.6 airplane # emoji-test.txt line #3253 Emoji version 13.0
is Uni.new(0x2708, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2708, 0xFE0F⟆ ✈️ E0.6 airplane";
## 1F6E9 FE0F                                 ; fully-qualified     # 🛩️ E0.7 small airplane # emoji-test.txt line #3255 Emoji version 13.0
is Uni.new(0x1F6E9, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6E9, 0xFE0F⟆ 🛩️ E0.7 small airplane";
## 1F6F0 FE0F                                 ; fully-qualified     # 🛰️ E0.7 satellite # emoji-test.txt line #3265 Emoji version 13.0
is Uni.new(0x1F6F0, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6F0, 0xFE0F⟆ 🛰️ E0.7 satellite";
## 1F6CE FE0F                                 ; fully-qualified     # 🛎️ E0.7 bellhop bell # emoji-test.txt line #3271 Emoji version 13.0
is Uni.new(0x1F6CE, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6CE, 0xFE0F⟆ 🛎️ E0.7 bellhop bell";
## 23F1 FE0F                                  ; fully-qualified     # ⏱️ E1.0 stopwatch # emoji-test.txt line #3280 Emoji version 13.0
is Uni.new(0x23F1, 0xFE0F).Str.chars, 1, "Codes: ⟅0x23F1, 0xFE0F⟆ ⏱️ E1.0 stopwatch";
## 23F2 FE0F                                  ; fully-qualified     # ⏲️ E1.0 timer clock # emoji-test.txt line #3282 Emoji version 13.0
is Uni.new(0x23F2, 0xFE0F).Str.chars, 1, "Codes: ⟅0x23F2, 0xFE0F⟆ ⏲️ E1.0 timer clock";
## 1F570 FE0F                                 ; fully-qualified     # 🕰️ E0.7 mantelpiece clock # emoji-test.txt line #3284 Emoji version 13.0
is Uni.new(0x1F570, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F570, 0xFE0F⟆ 🕰️ E0.7 mantelpiece clock";
## 1F321 FE0F                                 ; fully-qualified     # 🌡️ E0.7 thermometer # emoji-test.txt line #3324 Emoji version 13.0
is Uni.new(0x1F321, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F321, 0xFE0F⟆ 🌡️ E0.7 thermometer";
## 2600 FE0F                                  ; fully-qualified     # ☀️ E0.6 sun # emoji-test.txt line #3326 Emoji version 13.0
is Uni.new(0x2600, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2600, 0xFE0F⟆ ☀️ E0.6 sun";
## 2601 FE0F                                  ; fully-qualified     # ☁️ E0.6 cloud # emoji-test.txt line #3335 Emoji version 13.0
is Uni.new(0x2601, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2601, 0xFE0F⟆ ☁️ E0.6 cloud";
## 26C8 FE0F                                  ; fully-qualified     # ⛈️ E0.7 cloud with lightning and rain # emoji-test.txt line #3338 Emoji version 13.0
is Uni.new(0x26C8, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26C8, 0xFE0F⟆ ⛈️ E0.7 cloud with lightning and rain";
## 1F324 FE0F                                 ; fully-qualified     # 🌤️ E0.7 sun behind small cloud # emoji-test.txt line #3340 Emoji version 13.0
is Uni.new(0x1F324, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F324, 0xFE0F⟆ 🌤️ E0.7 sun behind small cloud";
## 1F325 FE0F                                 ; fully-qualified     # 🌥️ E0.7 sun behind large cloud # emoji-test.txt line #3342 Emoji version 13.0
is Uni.new(0x1F325, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F325, 0xFE0F⟆ 🌥️ E0.7 sun behind large cloud";
## 1F326 FE0F                                 ; fully-qualified     # 🌦️ E0.7 sun behind rain cloud # emoji-test.txt line #3344 Emoji version 13.0
is Uni.new(0x1F326, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F326, 0xFE0F⟆ 🌦️ E0.7 sun behind rain cloud";
## 1F327 FE0F                                 ; fully-qualified     # 🌧️ E0.7 cloud with rain # emoji-test.txt line #3346 Emoji version 13.0
is Uni.new(0x1F327, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F327, 0xFE0F⟆ 🌧️ E0.7 cloud with rain";
## 1F328 FE0F                                 ; fully-qualified     # 🌨️ E0.7 cloud with snow # emoji-test.txt line #3348 Emoji version 13.0
is Uni.new(0x1F328, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F328, 0xFE0F⟆ 🌨️ E0.7 cloud with snow";
## 1F329 FE0F                                 ; fully-qualified     # 🌩️ E0.7 cloud with lightning # emoji-test.txt line #3350 Emoji version 13.0
is Uni.new(0x1F329, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F329, 0xFE0F⟆ 🌩️ E0.7 cloud with lightning";
## 1F32A FE0F                                 ; fully-qualified     # 🌪️ E0.7 tornado # emoji-test.txt line #3352 Emoji version 13.0
is Uni.new(0x1F32A, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F32A, 0xFE0F⟆ 🌪️ E0.7 tornado";
## 1F32B FE0F                                 ; fully-qualified     # 🌫️ E0.7 fog # emoji-test.txt line #3354 Emoji version 13.0
is Uni.new(0x1F32B, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F32B, 0xFE0F⟆ 🌫️ E0.7 fog";
## 1F32C FE0F                                 ; fully-qualified     # 🌬️ E0.7 wind face # emoji-test.txt line #3356 Emoji version 13.0
is Uni.new(0x1F32C, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F32C, 0xFE0F⟆ 🌬️ E0.7 wind face";
## 2602 FE0F                                  ; fully-qualified     # ☂️ E0.7 umbrella # emoji-test.txt line #3361 Emoji version 13.0
is Uni.new(0x2602, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2602, 0xFE0F⟆ ☂️ E0.7 umbrella";
## 26F1 FE0F                                  ; fully-qualified     # ⛱️ E0.7 umbrella on ground # emoji-test.txt line #3364 Emoji version 13.0
is Uni.new(0x26F1, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F1, 0xFE0F⟆ ⛱️ E0.7 umbrella on ground";
## 2744 FE0F                                  ; fully-qualified     # ❄️ E0.6 snowflake # emoji-test.txt line #3367 Emoji version 13.0
is Uni.new(0x2744, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2744, 0xFE0F⟆ ❄️ E0.6 snowflake";
## 2603 FE0F                                  ; fully-qualified     # ☃️ E0.7 snowman # emoji-test.txt line #3369 Emoji version 13.0
is Uni.new(0x2603, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2603, 0xFE0F⟆ ☃️ E0.7 snowman";
## 2604 FE0F                                  ; fully-qualified     # ☄️ E1.0 comet # emoji-test.txt line #3372 Emoji version 13.0
is Uni.new(0x2604, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2604, 0xFE0F⟆ ☄️ E1.0 comet";
## 1F397 FE0F                                 ; fully-qualified     # 🎗️ E0.7 reminder ribbon # emoji-test.txt line #3402 Emoji version 13.0
is Uni.new(0x1F397, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F397, 0xFE0F⟆ 🎗️ E0.7 reminder ribbon";
## 1F39F FE0F                                 ; fully-qualified     # 🎟️ E0.7 admission tickets # emoji-test.txt line #3404 Emoji version 13.0
is Uni.new(0x1F39F, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F39F, 0xFE0F⟆ 🎟️ E0.7 admission tickets";
## 1F396 FE0F                                 ; fully-qualified     # 🎖️ E0.7 military medal # emoji-test.txt line #3409 Emoji version 13.0
is Uni.new(0x1F396, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F396, 0xFE0F⟆ 🎖️ E0.7 military medal";
## 26F8 FE0F                                  ; fully-qualified     # ⛸️ E0.7 ice skate # emoji-test.txt line #3438 Emoji version 13.0
is Uni.new(0x26F8, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26F8, 0xFE0F⟆ ⛸️ E0.7 ice skate";
## 1F579 FE0F                                 ; fully-qualified     # 🕹️ E0.7 joystick # emoji-test.txt line #3456 Emoji version 13.0
is Uni.new(0x1F579, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F579, 0xFE0F⟆ 🕹️ E0.7 joystick";
## 2660 FE0F                                  ; fully-qualified     # ♠️ E0.6 spade suit # emoji-test.txt line #3464 Emoji version 13.0
is Uni.new(0x2660, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2660, 0xFE0F⟆ ♠️ E0.6 spade suit";
## 2665 FE0F                                  ; fully-qualified     # ♥️ E0.6 heart suit # emoji-test.txt line #3466 Emoji version 13.0
is Uni.new(0x2665, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2665, 0xFE0F⟆ ♥️ E0.6 heart suit";
## 2666 FE0F                                  ; fully-qualified     # ♦️ E0.6 diamond suit # emoji-test.txt line #3468 Emoji version 13.0
is Uni.new(0x2666, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2666, 0xFE0F⟆ ♦️ E0.6 diamond suit";
## 2663 FE0F                                  ; fully-qualified     # ♣️ E0.6 club suit # emoji-test.txt line #3470 Emoji version 13.0
is Uni.new(0x2663, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2663, 0xFE0F⟆ ♣️ E0.6 club suit";
## 265F FE0F                                  ; fully-qualified     # ♟️ E11.0 chess pawn # emoji-test.txt line #3472 Emoji version 13.0
is Uni.new(0x265F, 0xFE0F).Str.chars, 1, "Codes: ⟅0x265F, 0xFE0F⟆ ♟️ E11.0 chess pawn";
## 1F5BC FE0F                                 ; fully-qualified     # 🖼️ E0.7 framed picture # emoji-test.txt line #3480 Emoji version 13.0
is Uni.new(0x1F5BC, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5BC, 0xFE0F⟆ 🖼️ E0.7 framed picture";
## 1F576 FE0F                                 ; fully-qualified     # 🕶️ E0.7 sunglasses # emoji-test.txt line #3495 Emoji version 13.0
is Uni.new(0x1F576, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F576, 0xFE0F⟆ 🕶️ E0.7 sunglasses";
## 1F6CD FE0F                                 ; fully-qualified     # 🛍️ E0.7 shopping bags # emoji-test.txt line #3518 Emoji version 13.0
is Uni.new(0x1F6CD, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6CD, 0xFE0F⟆ 🛍️ E0.7 shopping bags";
## 26D1 FE0F                                  ; fully-qualified     # ⛑️ E0.7 rescue worker’s helmet # emoji-test.txt line #3536 Emoji version 13.0
is Uni.new(0x26D1, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26D1, 0xFE0F⟆ ⛑️ E0.7 rescue worker’s helmet";
## 1F399 FE0F                                 ; fully-qualified     # 🎙️ E0.7 studio microphone # emoji-test.txt line #3558 Emoji version 13.0
is Uni.new(0x1F399, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F399, 0xFE0F⟆ 🎙️ E0.7 studio microphone";
## 1F39A FE0F                                 ; fully-qualified     # 🎚️ E0.7 level slider # emoji-test.txt line #3560 Emoji version 13.0
is Uni.new(0x1F39A, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F39A, 0xFE0F⟆ 🎚️ E0.7 level slider";
## 1F39B FE0F                                 ; fully-qualified     # 🎛️ E0.7 control knobs # emoji-test.txt line #3562 Emoji version 13.0
is Uni.new(0x1F39B, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F39B, 0xFE0F⟆ 🎛️ E0.7 control knobs";
## 260E FE0F                                  ; fully-qualified     # ☎️ E0.6 telephone # emoji-test.txt line #3582 Emoji version 13.0
is Uni.new(0x260E, 0xFE0F).Str.chars, 1, "Codes: ⟅0x260E, 0xFE0F⟆ ☎️ E0.6 telephone";
## 1F5A5 FE0F                                 ; fully-qualified     # 🖥️ E0.7 desktop computer # emoji-test.txt line #3592 Emoji version 13.0
is Uni.new(0x1F5A5, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5A5, 0xFE0F⟆ 🖥️ E0.7 desktop computer";
## 1F5A8 FE0F                                 ; fully-qualified     # 🖨️ E0.7 printer # emoji-test.txt line #3594 Emoji version 13.0
is Uni.new(0x1F5A8, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5A8, 0xFE0F⟆ 🖨️ E0.7 printer";
## 2328 FE0F                                  ; fully-qualified     # ⌨️ E1.0 keyboard # emoji-test.txt line #3596 Emoji version 13.0
is Uni.new(0x2328, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2328, 0xFE0F⟆ ⌨️ E1.0 keyboard";
## 1F5B1 FE0F                                 ; fully-qualified     # 🖱️ E0.7 computer mouse # emoji-test.txt line #3598 Emoji version 13.0
is Uni.new(0x1F5B1, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5B1, 0xFE0F⟆ 🖱️ E0.7 computer mouse";
## 1F5B2 FE0F                                 ; fully-qualified     # 🖲️ E0.7 trackball # emoji-test.txt line #3600 Emoji version 13.0
is Uni.new(0x1F5B2, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5B2, 0xFE0F⟆ 🖲️ E0.7 trackball";
## 1F39E FE0F                                 ; fully-qualified     # 🎞️ E0.7 film frames # emoji-test.txt line #3610 Emoji version 13.0
is Uni.new(0x1F39E, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F39E, 0xFE0F⟆ 🎞️ E0.7 film frames";
## 1F4FD FE0F                                 ; fully-qualified     # 📽️ E0.7 film projector # emoji-test.txt line #3612 Emoji version 13.0
is Uni.new(0x1F4FD, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F4FD, 0xFE0F⟆ 📽️ E0.7 film projector";
## 1F56F FE0F                                 ; fully-qualified     # 🕯️ E0.7 candle # emoji-test.txt line #3622 Emoji version 13.0
is Uni.new(0x1F56F, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F56F, 0xFE0F⟆ 🕯️ E0.7 candle";
## 1F5DE FE0F                                 ; fully-qualified     # 🗞️ E0.7 rolled-up newspaper # emoji-test.txt line #3643 Emoji version 13.0
is Uni.new(0x1F5DE, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5DE, 0xFE0F⟆ 🗞️ E0.7 rolled-up newspaper";
## 1F3F7 FE0F                                 ; fully-qualified     # 🏷️ E0.7 label # emoji-test.txt line #3647 Emoji version 13.0
is Uni.new(0x1F3F7, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3F7, 0xFE0F⟆ 🏷️ E0.7 label";
## 2709 FE0F                                  ; fully-qualified     # ✉️ E0.6 envelope # emoji-test.txt line #3663 Emoji version 13.0
is Uni.new(0x2709, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2709, 0xFE0F⟆ ✉️ E0.6 envelope";
## 1F5F3 FE0F                                 ; fully-qualified     # 🗳️ E0.7 ballot box with ballot # emoji-test.txt line #3676 Emoji version 13.0
is Uni.new(0x1F5F3, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5F3, 0xFE0F⟆ 🗳️ E0.7 ballot box with ballot";
## 270F FE0F                                  ; fully-qualified     # ✏️ E0.6 pencil # emoji-test.txt line #3680 Emoji version 13.0
is Uni.new(0x270F, 0xFE0F).Str.chars, 1, "Codes: ⟅0x270F, 0xFE0F⟆ ✏️ E0.6 pencil";
## 2712 FE0F                                  ; fully-qualified     # ✒️ E0.6 black nib # emoji-test.txt line #3682 Emoji version 13.0
is Uni.new(0x2712, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2712, 0xFE0F⟆ ✒️ E0.6 black nib";
## 1F58B FE0F                                 ; fully-qualified     # 🖋️ E0.7 fountain pen # emoji-test.txt line #3684 Emoji version 13.0
is Uni.new(0x1F58B, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F58B, 0xFE0F⟆ 🖋️ E0.7 fountain pen";
## 1F58A FE0F                                 ; fully-qualified     # 🖊️ E0.7 pen # emoji-test.txt line #3686 Emoji version 13.0
is Uni.new(0x1F58A, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F58A, 0xFE0F⟆ 🖊️ E0.7 pen";
## 1F58C FE0F                                 ; fully-qualified     # 🖌️ E0.7 paintbrush # emoji-test.txt line #3688 Emoji version 13.0
is Uni.new(0x1F58C, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F58C, 0xFE0F⟆ 🖌️ E0.7 paintbrush";
## 1F58D FE0F                                 ; fully-qualified     # 🖍️ E0.7 crayon # emoji-test.txt line #3690 Emoji version 13.0
is Uni.new(0x1F58D, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F58D, 0xFE0F⟆ 🖍️ E0.7 crayon";
## 1F5C2 FE0F                                 ; fully-qualified     # 🗂️ E0.7 card index dividers # emoji-test.txt line #3698 Emoji version 13.0
is Uni.new(0x1F5C2, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5C2, 0xFE0F⟆ 🗂️ E0.7 card index dividers";
## 1F5D2 FE0F                                 ; fully-qualified     # 🗒️ E0.7 spiral notepad # emoji-test.txt line #3702 Emoji version 13.0
is Uni.new(0x1F5D2, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5D2, 0xFE0F⟆ 🗒️ E0.7 spiral notepad";
## 1F5D3 FE0F                                 ; fully-qualified     # 🗓️ E0.7 spiral calendar # emoji-test.txt line #3704 Emoji version 13.0
is Uni.new(0x1F5D3, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5D3, 0xFE0F⟆ 🗓️ E0.7 spiral calendar";
## 1F587 FE0F                                 ; fully-qualified     # 🖇️ E0.7 linked paperclips # emoji-test.txt line #3714 Emoji version 13.0
is Uni.new(0x1F587, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F587, 0xFE0F⟆ 🖇️ E0.7 linked paperclips";
## 2702 FE0F                                  ; fully-qualified     # ✂️ E0.6 scissors # emoji-test.txt line #3718 Emoji version 13.0
is Uni.new(0x2702, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2702, 0xFE0F⟆ ✂️ E0.6 scissors";
## 1F5C3 FE0F                                 ; fully-qualified     # 🗃️ E0.7 card file box # emoji-test.txt line #3720 Emoji version 13.0
is Uni.new(0x1F5C3, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5C3, 0xFE0F⟆ 🗃️ E0.7 card file box";
## 1F5C4 FE0F                                 ; fully-qualified     # 🗄️ E0.7 file cabinet # emoji-test.txt line #3722 Emoji version 13.0
is Uni.new(0x1F5C4, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5C4, 0xFE0F⟆ 🗄️ E0.7 file cabinet";
## 1F5D1 FE0F                                 ; fully-qualified     # 🗑️ E0.7 wastebasket # emoji-test.txt line #3724 Emoji version 13.0
is Uni.new(0x1F5D1, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5D1, 0xFE0F⟆ 🗑️ E0.7 wastebasket";
## 1F5DD FE0F                                 ; fully-qualified     # 🗝️ E0.7 old key # emoji-test.txt line #3733 Emoji version 13.0
is Uni.new(0x1F5DD, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5DD, 0xFE0F⟆ 🗝️ E0.7 old key";
## 26CF FE0F                                  ; fully-qualified     # ⛏️ E0.7 pick # emoji-test.txt line #3739 Emoji version 13.0
is Uni.new(0x26CF, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26CF, 0xFE0F⟆ ⛏️ E0.7 pick";
## 2692 FE0F                                  ; fully-qualified     # ⚒️ E1.0 hammer and pick # emoji-test.txt line #3741 Emoji version 13.0
is Uni.new(0x2692, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2692, 0xFE0F⟆ ⚒️ E1.0 hammer and pick";
## 1F6E0 FE0F                                 ; fully-qualified     # 🛠️ E0.7 hammer and wrench # emoji-test.txt line #3743 Emoji version 13.0
is Uni.new(0x1F6E0, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6E0, 0xFE0F⟆ 🛠️ E0.7 hammer and wrench";
## 1F5E1 FE0F                                 ; fully-qualified     # 🗡️ E0.7 dagger # emoji-test.txt line #3745 Emoji version 13.0
is Uni.new(0x1F5E1, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5E1, 0xFE0F⟆ 🗡️ E0.7 dagger";
## 2694 FE0F                                  ; fully-qualified     # ⚔️ E1.0 crossed swords # emoji-test.txt line #3747 Emoji version 13.0
is Uni.new(0x2694, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2694, 0xFE0F⟆ ⚔️ E1.0 crossed swords";
## 1F6E1 FE0F                                 ; fully-qualified     # 🛡️ E0.7 shield # emoji-test.txt line #3752 Emoji version 13.0
is Uni.new(0x1F6E1, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6E1, 0xFE0F⟆ 🛡️ E0.7 shield";
## 2699 FE0F                                  ; fully-qualified     # ⚙️ E1.0 gear # emoji-test.txt line #3758 Emoji version 13.0
is Uni.new(0x2699, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2699, 0xFE0F⟆ ⚙️ E1.0 gear";
## 1F5DC FE0F                                 ; fully-qualified     # 🗜️ E0.7 clamp # emoji-test.txt line #3760 Emoji version 13.0
is Uni.new(0x1F5DC, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F5DC, 0xFE0F⟆ 🗜️ E0.7 clamp";
## 2696 FE0F                                  ; fully-qualified     # ⚖️ E1.0 balance scale # emoji-test.txt line #3762 Emoji version 13.0
is Uni.new(0x2696, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2696, 0xFE0F⟆ ⚖️ E1.0 balance scale";
## 26D3 FE0F                                  ; fully-qualified     # ⛓️ E0.7 chains # emoji-test.txt line #3766 Emoji version 13.0
is Uni.new(0x26D3, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26D3, 0xFE0F⟆ ⛓️ E0.7 chains";
## 2697 FE0F                                  ; fully-qualified     # ⚗️ E1.0 alembic # emoji-test.txt line #3774 Emoji version 13.0
is Uni.new(0x2697, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2697, 0xFE0F⟆ ⚗️ E1.0 alembic";
## 1F6CF FE0F                                 ; fully-qualified     # 🛏️ E0.7 bed # emoji-test.txt line #3795 Emoji version 13.0
is Uni.new(0x1F6CF, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6CF, 0xFE0F⟆ 🛏️ E0.7 bed";
## 1F6CB FE0F                                 ; fully-qualified     # 🛋️ E0.7 couch and lamp # emoji-test.txt line #3797 Emoji version 13.0
is Uni.new(0x1F6CB, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F6CB, 0xFE0F⟆ 🛋️ E0.7 couch and lamp";
## 26B0 FE0F                                  ; fully-qualified     # ⚰️ E1.0 coffin # emoji-test.txt line #3820 Emoji version 13.0
is Uni.new(0x26B0, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26B0, 0xFE0F⟆ ⚰️ E1.0 coffin";
## 26B1 FE0F                                  ; fully-qualified     # ⚱️ E1.0 funeral urn # emoji-test.txt line #3823 Emoji version 13.0
is Uni.new(0x26B1, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26B1, 0xFE0F⟆ ⚱️ E1.0 funeral urn";
## 26A0 FE0F                                  ; fully-qualified     # ⚠️ E0.6 warning # emoji-test.txt line #3849 Emoji version 13.0
is Uni.new(0x26A0, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26A0, 0xFE0F⟆ ⚠️ E0.6 warning";
## 2622 FE0F                                  ; fully-qualified     # ☢️ E1.0 radioactive # emoji-test.txt line #3861 Emoji version 13.0
is Uni.new(0x2622, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2622, 0xFE0F⟆ ☢️ E1.0 radioactive";
## 2623 FE0F                                  ; fully-qualified     # ☣️ E1.0 biohazard # emoji-test.txt line #3863 Emoji version 13.0
is Uni.new(0x2623, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2623, 0xFE0F⟆ ☣️ E1.0 biohazard";
## 2B06 FE0F                                  ; fully-qualified     # ⬆️ E0.6 up arrow # emoji-test.txt line #3867 Emoji version 13.0
is Uni.new(0x2B06, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2B06, 0xFE0F⟆ ⬆️ E0.6 up arrow";
## 2197 FE0F                                  ; fully-qualified     # ↗️ E0.6 up-right arrow # emoji-test.txt line #3869 Emoji version 13.0
is Uni.new(0x2197, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2197, 0xFE0F⟆ ↗️ E0.6 up-right arrow";
## 27A1 FE0F                                  ; fully-qualified     # ➡️ E0.6 right arrow # emoji-test.txt line #3871 Emoji version 13.0
is Uni.new(0x27A1, 0xFE0F).Str.chars, 1, "Codes: ⟅0x27A1, 0xFE0F⟆ ➡️ E0.6 right arrow";
## 2198 FE0F                                  ; fully-qualified     # ↘️ E0.6 down-right arrow # emoji-test.txt line #3873 Emoji version 13.0
is Uni.new(0x2198, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2198, 0xFE0F⟆ ↘️ E0.6 down-right arrow";
## 2B07 FE0F                                  ; fully-qualified     # ⬇️ E0.6 down arrow # emoji-test.txt line #3875 Emoji version 13.0
is Uni.new(0x2B07, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2B07, 0xFE0F⟆ ⬇️ E0.6 down arrow";
## 2199 FE0F                                  ; fully-qualified     # ↙️ E0.6 down-left arrow # emoji-test.txt line #3877 Emoji version 13.0
is Uni.new(0x2199, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2199, 0xFE0F⟆ ↙️ E0.6 down-left arrow";
## 2B05 FE0F                                  ; fully-qualified     # ⬅️ E0.6 left arrow # emoji-test.txt line #3879 Emoji version 13.0
is Uni.new(0x2B05, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2B05, 0xFE0F⟆ ⬅️ E0.6 left arrow";
## 2196 FE0F                                  ; fully-qualified     # ↖️ E0.6 up-left arrow # emoji-test.txt line #3881 Emoji version 13.0
is Uni.new(0x2196, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2196, 0xFE0F⟆ ↖️ E0.6 up-left arrow";
## 2195 FE0F                                  ; fully-qualified     # ↕️ E0.6 up-down arrow # emoji-test.txt line #3883 Emoji version 13.0
is Uni.new(0x2195, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2195, 0xFE0F⟆ ↕️ E0.6 up-down arrow";
## 2194 FE0F                                  ; fully-qualified     # ↔️ E0.6 left-right arrow # emoji-test.txt line #3885 Emoji version 13.0
is Uni.new(0x2194, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2194, 0xFE0F⟆ ↔️ E0.6 left-right arrow";
## 21A9 FE0F                                  ; fully-qualified     # ↩️ E0.6 right arrow curving left # emoji-test.txt line #3887 Emoji version 13.0
is Uni.new(0x21A9, 0xFE0F).Str.chars, 1, "Codes: ⟅0x21A9, 0xFE0F⟆ ↩️ E0.6 right arrow curving left";
## 21AA FE0F                                  ; fully-qualified     # ↪️ E0.6 left arrow curving right # emoji-test.txt line #3889 Emoji version 13.0
is Uni.new(0x21AA, 0xFE0F).Str.chars, 1, "Codes: ⟅0x21AA, 0xFE0F⟆ ↪️ E0.6 left arrow curving right";
## 2934 FE0F                                  ; fully-qualified     # ⤴️ E0.6 right arrow curving up # emoji-test.txt line #3891 Emoji version 13.0
is Uni.new(0x2934, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2934, 0xFE0F⟆ ⤴️ E0.6 right arrow curving up";
## 2935 FE0F                                  ; fully-qualified     # ⤵️ E0.6 right arrow curving down # emoji-test.txt line #3893 Emoji version 13.0
is Uni.new(0x2935, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2935, 0xFE0F⟆ ⤵️ E0.6 right arrow curving down";
## 269B FE0F                                  ; fully-qualified     # ⚛️ E1.0 atom symbol # emoji-test.txt line #3905 Emoji version 13.0
is Uni.new(0x269B, 0xFE0F).Str.chars, 1, "Codes: ⟅0x269B, 0xFE0F⟆ ⚛️ E1.0 atom symbol";
## 1F549 FE0F                                 ; fully-qualified     # 🕉️ E0.7 om # emoji-test.txt line #3907 Emoji version 13.0
is Uni.new(0x1F549, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F549, 0xFE0F⟆ 🕉️ E0.7 om";
## 2721 FE0F                                  ; fully-qualified     # ✡️ E0.7 star of David # emoji-test.txt line #3909 Emoji version 13.0
is Uni.new(0x2721, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2721, 0xFE0F⟆ ✡️ E0.7 star of David";
## 2638 FE0F                                  ; fully-qualified     # ☸️ E0.7 wheel of dharma # emoji-test.txt line #3911 Emoji version 13.0
is Uni.new(0x2638, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2638, 0xFE0F⟆ ☸️ E0.7 wheel of dharma";
## 262F FE0F                                  ; fully-qualified     # ☯️ E0.7 yin yang # emoji-test.txt line #3913 Emoji version 13.0
is Uni.new(0x262F, 0xFE0F).Str.chars, 1, "Codes: ⟅0x262F, 0xFE0F⟆ ☯️ E0.7 yin yang";
## 271D FE0F                                  ; fully-qualified     # ✝️ E0.7 latin cross # emoji-test.txt line #3915 Emoji version 13.0
is Uni.new(0x271D, 0xFE0F).Str.chars, 1, "Codes: ⟅0x271D, 0xFE0F⟆ ✝️ E0.7 latin cross";
## 2626 FE0F                                  ; fully-qualified     # ☦️ E1.0 orthodox cross # emoji-test.txt line #3917 Emoji version 13.0
is Uni.new(0x2626, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2626, 0xFE0F⟆ ☦️ E1.0 orthodox cross";
## 262A FE0F                                  ; fully-qualified     # ☪️ E0.7 star and crescent # emoji-test.txt line #3919 Emoji version 13.0
is Uni.new(0x262A, 0xFE0F).Str.chars, 1, "Codes: ⟅0x262A, 0xFE0F⟆ ☪️ E0.7 star and crescent";
## 262E FE0F                                  ; fully-qualified     # ☮️ E1.0 peace symbol # emoji-test.txt line #3921 Emoji version 13.0
is Uni.new(0x262E, 0xFE0F).Str.chars, 1, "Codes: ⟅0x262E, 0xFE0F⟆ ☮️ E1.0 peace symbol";
## 25B6 FE0F                                  ; fully-qualified     # ▶️ E0.6 play button # emoji-test.txt line #3945 Emoji version 13.0
is Uni.new(0x25B6, 0xFE0F).Str.chars, 1, "Codes: ⟅0x25B6, 0xFE0F⟆ ▶️ E0.6 play button";
## 23ED FE0F                                  ; fully-qualified     # ⏭️ E0.7 next track button # emoji-test.txt line #3948 Emoji version 13.0
is Uni.new(0x23ED, 0xFE0F).Str.chars, 1, "Codes: ⟅0x23ED, 0xFE0F⟆ ⏭️ E0.7 next track button";
## 23EF FE0F                                  ; fully-qualified     # ⏯️ E1.0 play or pause button # emoji-test.txt line #3950 Emoji version 13.0
is Uni.new(0x23EF, 0xFE0F).Str.chars, 1, "Codes: ⟅0x23EF, 0xFE0F⟆ ⏯️ E1.0 play or pause button";
## 25C0 FE0F                                  ; fully-qualified     # ◀️ E0.6 reverse button # emoji-test.txt line #3952 Emoji version 13.0
is Uni.new(0x25C0, 0xFE0F).Str.chars, 1, "Codes: ⟅0x25C0, 0xFE0F⟆ ◀️ E0.6 reverse button";
## 23EE FE0F                                  ; fully-qualified     # ⏮️ E0.7 last track button # emoji-test.txt line #3955 Emoji version 13.0
is Uni.new(0x23EE, 0xFE0F).Str.chars, 1, "Codes: ⟅0x23EE, 0xFE0F⟆ ⏮️ E0.7 last track button";
## 23F8 FE0F                                  ; fully-qualified     # ⏸️ E0.7 pause button # emoji-test.txt line #3961 Emoji version 13.0
is Uni.new(0x23F8, 0xFE0F).Str.chars, 1, "Codes: ⟅0x23F8, 0xFE0F⟆ ⏸️ E0.7 pause button";
## 23F9 FE0F                                  ; fully-qualified     # ⏹️ E0.7 stop button # emoji-test.txt line #3963 Emoji version 13.0
is Uni.new(0x23F9, 0xFE0F).Str.chars, 1, "Codes: ⟅0x23F9, 0xFE0F⟆ ⏹️ E0.7 stop button";
## 23FA FE0F                                  ; fully-qualified     # ⏺️ E0.7 record button # emoji-test.txt line #3965 Emoji version 13.0
is Uni.new(0x23FA, 0xFE0F).Str.chars, 1, "Codes: ⟅0x23FA, 0xFE0F⟆ ⏺️ E0.7 record button";
## 23CF FE0F                                  ; fully-qualified     # ⏏️ E1.0 eject button # emoji-test.txt line #3967 Emoji version 13.0
is Uni.new(0x23CF, 0xFE0F).Str.chars, 1, "Codes: ⟅0x23CF, 0xFE0F⟆ ⏏️ E1.0 eject button";
## 2640 FE0F                                  ; fully-qualified     # ♀️ E4.0 female sign # emoji-test.txt line #3977 Emoji version 13.0
is Uni.new(0x2640, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2640, 0xFE0F⟆ ♀️ E4.0 female sign";
## 2642 FE0F                                  ; fully-qualified     # ♂️ E4.0 male sign # emoji-test.txt line #3979 Emoji version 13.0
is Uni.new(0x2642, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2642, 0xFE0F⟆ ♂️ E4.0 male sign";
## 26A7 FE0F                                  ; fully-qualified     # ⚧️ E13.0 transgender symbol # emoji-test.txt line #3981 Emoji version 13.0
is Uni.new(0x26A7, 0xFE0F).Str.chars, 1, "Codes: ⟅0x26A7, 0xFE0F⟆ ⚧️ E13.0 transgender symbol";
## 2716 FE0F                                  ; fully-qualified     # ✖️ E0.6 multiply # emoji-test.txt line #3985 Emoji version 13.0
is Uni.new(0x2716, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2716, 0xFE0F⟆ ✖️ E0.6 multiply";
## 267E FE0F                                  ; fully-qualified     # ♾️ E11.0 infinity # emoji-test.txt line #3990 Emoji version 13.0
is Uni.new(0x267E, 0xFE0F).Str.chars, 1, "Codes: ⟅0x267E, 0xFE0F⟆ ♾️ E11.0 infinity";
## 203C FE0F                                  ; fully-qualified     # ‼️ E0.6 double exclamation mark # emoji-test.txt line #3994 Emoji version 13.0
is Uni.new(0x203C, 0xFE0F).Str.chars, 1, "Codes: ⟅0x203C, 0xFE0F⟆ ‼️ E0.6 double exclamation mark";
## 2049 FE0F                                  ; fully-qualified     # ⁉️ E0.6 exclamation question mark # emoji-test.txt line #3996 Emoji version 13.0
is Uni.new(0x2049, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2049, 0xFE0F⟆ ⁉️ E0.6 exclamation question mark";
## 3030 FE0F                                  ; fully-qualified     # 〰️ E0.6 wavy dash # emoji-test.txt line #4002 Emoji version 13.0
is Uni.new(0x3030, 0xFE0F).Str.chars, 1, "Codes: ⟅0x3030, 0xFE0F⟆ 〰️ E0.6 wavy dash";
## 2695 FE0F                                  ; fully-qualified     # ⚕️ E4.0 medical symbol # emoji-test.txt line #4010 Emoji version 13.0
is Uni.new(0x2695, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2695, 0xFE0F⟆ ⚕️ E4.0 medical symbol";
## 267B FE0F                                  ; fully-qualified     # ♻️ E0.6 recycling symbol # emoji-test.txt line #4012 Emoji version 13.0
is Uni.new(0x267B, 0xFE0F).Str.chars, 1, "Codes: ⟅0x267B, 0xFE0F⟆ ♻️ E0.6 recycling symbol";
## 269C FE0F                                  ; fully-qualified     # ⚜️ E1.0 fleur-de-lis # emoji-test.txt line #4014 Emoji version 13.0
is Uni.new(0x269C, 0xFE0F).Str.chars, 1, "Codes: ⟅0x269C, 0xFE0F⟆ ⚜️ E1.0 fleur-de-lis";
## 2611 FE0F                                  ; fully-qualified     # ☑️ E0.6 check box with check # emoji-test.txt line #4021 Emoji version 13.0
is Uni.new(0x2611, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2611, 0xFE0F⟆ ☑️ E0.6 check box with check";
## 2714 FE0F                                  ; fully-qualified     # ✔️ E0.6 check mark # emoji-test.txt line #4023 Emoji version 13.0
is Uni.new(0x2714, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2714, 0xFE0F⟆ ✔️ E0.6 check mark";
## 303D FE0F                                  ; fully-qualified     # 〽️ E0.6 part alternation mark # emoji-test.txt line #4029 Emoji version 13.0
is Uni.new(0x303D, 0xFE0F).Str.chars, 1, "Codes: ⟅0x303D, 0xFE0F⟆ 〽️ E0.6 part alternation mark";
## 2733 FE0F                                  ; fully-qualified     # ✳️ E0.6 eight-spoked asterisk # emoji-test.txt line #4031 Emoji version 13.0
is Uni.new(0x2733, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2733, 0xFE0F⟆ ✳️ E0.6 eight-spoked asterisk";
## 2734 FE0F                                  ; fully-qualified     # ✴️ E0.6 eight-pointed star # emoji-test.txt line #4033 Emoji version 13.0
is Uni.new(0x2734, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2734, 0xFE0F⟆ ✴️ E0.6 eight-pointed star";
## 2747 FE0F                                  ; fully-qualified     # ❇️ E0.6 sparkle # emoji-test.txt line #4035 Emoji version 13.0
is Uni.new(0x2747, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2747, 0xFE0F⟆ ❇️ E0.6 sparkle";
## 00A9 FE0F                                  ; fully-qualified     # ©️ E0.6 copyright # emoji-test.txt line #4037 Emoji version 13.0
is Uni.new(0xA9, 0xFE0F).Str.chars, 1, "Codes: ⟅0xA9, 0xFE0F⟆ ©️ E0.6 copyright";
## 00AE FE0F                                  ; fully-qualified     # ®️ E0.6 registered # emoji-test.txt line #4039 Emoji version 13.0
is Uni.new(0xAE, 0xFE0F).Str.chars, 1, "Codes: ⟅0xAE, 0xFE0F⟆ ®️ E0.6 registered";
## 2122 FE0F                                  ; fully-qualified     # ™️ E0.6 trade mark # emoji-test.txt line #4041 Emoji version 13.0
is Uni.new(0x2122, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2122, 0xFE0F⟆ ™️ E0.6 trade mark";
## 0023 FE0F 20E3                             ; fully-qualified     # #️⃣ E0.6 keycap: # # emoji-test.txt line #4045 Emoji version 13.0
is Uni.new(0x23, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x23, 0xFE0F, 0x20E3⟆ ";
## 0023 20E3                                  ; unqualified         # #⃣ E0.6 keycap: # # emoji-test.txt line #4046 Emoji version 13.0
is Uni.new(0x23, 0x20E3).Str.chars, 1, "Codes: ⟅0x23, 0x20E3⟆ ";
## 002A FE0F 20E3                             ; fully-qualified     # *️⃣ E2.0 keycap: * # emoji-test.txt line #4047 Emoji version 13.0
is Uni.new(0x2A, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x2A, 0xFE0F, 0x20E3⟆ *️⃣ E2.0 keycap: *";
## 002A 20E3                                  ; unqualified         # *⃣ E2.0 keycap: * # emoji-test.txt line #4048 Emoji version 13.0
is Uni.new(0x2A, 0x20E3).Str.chars, 1, "Codes: ⟅0x2A, 0x20E3⟆ *⃣ E2.0 keycap: *";
## 0030 FE0F 20E3                             ; fully-qualified     # 0️⃣ E0.6 keycap: 0 # emoji-test.txt line #4049 Emoji version 13.0
is Uni.new(0x30, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x30, 0xFE0F, 0x20E3⟆ 0️⃣ E0.6 keycap: 0";
## 0030 20E3                                  ; unqualified         # 0⃣ E0.6 keycap: 0 # emoji-test.txt line #4050 Emoji version 13.0
is Uni.new(0x30, 0x20E3).Str.chars, 1, "Codes: ⟅0x30, 0x20E3⟆ 0⃣ E0.6 keycap: 0";
## 0031 FE0F 20E3                             ; fully-qualified     # 1️⃣ E0.6 keycap: 1 # emoji-test.txt line #4051 Emoji version 13.0
is Uni.new(0x31, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x31, 0xFE0F, 0x20E3⟆ 1️⃣ E0.6 keycap: 1";
## 0031 20E3                                  ; unqualified         # 1⃣ E0.6 keycap: 1 # emoji-test.txt line #4052 Emoji version 13.0
is Uni.new(0x31, 0x20E3).Str.chars, 1, "Codes: ⟅0x31, 0x20E3⟆ 1⃣ E0.6 keycap: 1";
## 0032 FE0F 20E3                             ; fully-qualified     # 2️⃣ E0.6 keycap: 2 # emoji-test.txt line #4053 Emoji version 13.0
is Uni.new(0x32, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x32, 0xFE0F, 0x20E3⟆ 2️⃣ E0.6 keycap: 2";
## 0032 20E3                                  ; unqualified         # 2⃣ E0.6 keycap: 2 # emoji-test.txt line #4054 Emoji version 13.0
is Uni.new(0x32, 0x20E3).Str.chars, 1, "Codes: ⟅0x32, 0x20E3⟆ 2⃣ E0.6 keycap: 2";
## 0033 FE0F 20E3                             ; fully-qualified     # 3️⃣ E0.6 keycap: 3 # emoji-test.txt line #4055 Emoji version 13.0
is Uni.new(0x33, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x33, 0xFE0F, 0x20E3⟆ 3️⃣ E0.6 keycap: 3";
## 0033 20E3                                  ; unqualified         # 3⃣ E0.6 keycap: 3 # emoji-test.txt line #4056 Emoji version 13.0
is Uni.new(0x33, 0x20E3).Str.chars, 1, "Codes: ⟅0x33, 0x20E3⟆ 3⃣ E0.6 keycap: 3";
## 0034 FE0F 20E3                             ; fully-qualified     # 4️⃣ E0.6 keycap: 4 # emoji-test.txt line #4057 Emoji version 13.0
is Uni.new(0x34, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x34, 0xFE0F, 0x20E3⟆ 4️⃣ E0.6 keycap: 4";
## 0034 20E3                                  ; unqualified         # 4⃣ E0.6 keycap: 4 # emoji-test.txt line #4058 Emoji version 13.0
is Uni.new(0x34, 0x20E3).Str.chars, 1, "Codes: ⟅0x34, 0x20E3⟆ 4⃣ E0.6 keycap: 4";
## 0035 FE0F 20E3                             ; fully-qualified     # 5️⃣ E0.6 keycap: 5 # emoji-test.txt line #4059 Emoji version 13.0
is Uni.new(0x35, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x35, 0xFE0F, 0x20E3⟆ 5️⃣ E0.6 keycap: 5";
## 0035 20E3                                  ; unqualified         # 5⃣ E0.6 keycap: 5 # emoji-test.txt line #4060 Emoji version 13.0
is Uni.new(0x35, 0x20E3).Str.chars, 1, "Codes: ⟅0x35, 0x20E3⟆ 5⃣ E0.6 keycap: 5";
## 0036 FE0F 20E3                             ; fully-qualified     # 6️⃣ E0.6 keycap: 6 # emoji-test.txt line #4061 Emoji version 13.0
is Uni.new(0x36, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x36, 0xFE0F, 0x20E3⟆ 6️⃣ E0.6 keycap: 6";
## 0036 20E3                                  ; unqualified         # 6⃣ E0.6 keycap: 6 # emoji-test.txt line #4062 Emoji version 13.0
is Uni.new(0x36, 0x20E3).Str.chars, 1, "Codes: ⟅0x36, 0x20E3⟆ 6⃣ E0.6 keycap: 6";
## 0037 FE0F 20E3                             ; fully-qualified     # 7️⃣ E0.6 keycap: 7 # emoji-test.txt line #4063 Emoji version 13.0
is Uni.new(0x37, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x37, 0xFE0F, 0x20E3⟆ 7️⃣ E0.6 keycap: 7";
## 0037 20E3                                  ; unqualified         # 7⃣ E0.6 keycap: 7 # emoji-test.txt line #4064 Emoji version 13.0
is Uni.new(0x37, 0x20E3).Str.chars, 1, "Codes: ⟅0x37, 0x20E3⟆ 7⃣ E0.6 keycap: 7";
## 0038 FE0F 20E3                             ; fully-qualified     # 8️⃣ E0.6 keycap: 8 # emoji-test.txt line #4065 Emoji version 13.0
is Uni.new(0x38, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x38, 0xFE0F, 0x20E3⟆ 8️⃣ E0.6 keycap: 8";
## 0038 20E3                                  ; unqualified         # 8⃣ E0.6 keycap: 8 # emoji-test.txt line #4066 Emoji version 13.0
is Uni.new(0x38, 0x20E3).Str.chars, 1, "Codes: ⟅0x38, 0x20E3⟆ 8⃣ E0.6 keycap: 8";
## 0039 FE0F 20E3                             ; fully-qualified     # 9️⃣ E0.6 keycap: 9 # emoji-test.txt line #4067 Emoji version 13.0
is Uni.new(0x39, 0xFE0F, 0x20E3).Str.chars, 1, "Codes: ⟅0x39, 0xFE0F, 0x20E3⟆ 9️⃣ E0.6 keycap: 9";
## 0039 20E3                                  ; unqualified         # 9⃣ E0.6 keycap: 9 # emoji-test.txt line #4068 Emoji version 13.0
is Uni.new(0x39, 0x20E3).Str.chars, 1, "Codes: ⟅0x39, 0x20E3⟆ 9⃣ E0.6 keycap: 9";
## 1F170 FE0F                                 ; fully-qualified     # 🅰️ E0.6 A button (blood type) # emoji-test.txt line #4077 Emoji version 13.0
is Uni.new(0x1F170, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F170, 0xFE0F⟆ 🅰️ E0.6 A button (blood type)";
## 1F171 FE0F                                 ; fully-qualified     # 🅱️ E0.6 B button (blood type) # emoji-test.txt line #4080 Emoji version 13.0
is Uni.new(0x1F171, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F171, 0xFE0F⟆ 🅱️ E0.6 B button (blood type)";
## 2139 FE0F                                  ; fully-qualified     # ℹ️ E0.6 information # emoji-test.txt line #4085 Emoji version 13.0
is Uni.new(0x2139, 0xFE0F).Str.chars, 1, "Codes: ⟅0x2139, 0xFE0F⟆ ℹ️ E0.6 information";
## 24C2 FE0F                                  ; fully-qualified     # Ⓜ️ E0.6 circled M # emoji-test.txt line #4088 Emoji version 13.0
is Uni.new(0x24C2, 0xFE0F).Str.chars, 1, "Codes: ⟅0x24C2, 0xFE0F⟆ Ⓜ️ E0.6 circled M";
## 1F17E FE0F                                 ; fully-qualified     # 🅾️ E0.6 O button (blood type) # emoji-test.txt line #4092 Emoji version 13.0
is Uni.new(0x1F17E, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F17E, 0xFE0F⟆ 🅾️ E0.6 O button (blood type)";
## 1F17F FE0F                                 ; fully-qualified     # 🅿️ E0.6 P button # emoji-test.txt line #4095 Emoji version 13.0
is Uni.new(0x1F17F, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F17F, 0xFE0F⟆ 🅿️ E0.6 P button";
## 1F202 FE0F                                 ; fully-qualified     # 🈂️ E0.6 Japanese “service charge” button # emoji-test.txt line #4101 Emoji version 13.0
is Uni.new(0x1F202, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F202, 0xFE0F⟆ 🈂️ E0.6 Japanese “service charge” button";
## 1F237 FE0F                                 ; fully-qualified     # 🈷️ E0.6 Japanese “monthly amount” button # emoji-test.txt line #4103 Emoji version 13.0
is Uni.new(0x1F237, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F237, 0xFE0F⟆ 🈷️ E0.6 Japanese “monthly amount” button";
## 3297 FE0F                                  ; fully-qualified     # ㊗️ E0.6 Japanese “congratulations” button # emoji-test.txt line #4115 Emoji version 13.0
is Uni.new(0x3297, 0xFE0F).Str.chars, 1, "Codes: ⟅0x3297, 0xFE0F⟆ ㊗️ E0.6 Japanese “congratulations” button";
## 3299 FE0F                                  ; fully-qualified     # ㊙️ E0.6 Japanese “secret” button # emoji-test.txt line #4117 Emoji version 13.0
is Uni.new(0x3299, 0xFE0F).Str.chars, 1, "Codes: ⟅0x3299, 0xFE0F⟆ ㊙️ E0.6 Japanese “secret” button";
## 25FC FE0F                                  ; fully-qualified     # ◼️ E0.6 black medium square # emoji-test.txt line #4141 Emoji version 13.0
is Uni.new(0x25FC, 0xFE0F).Str.chars, 1, "Codes: ⟅0x25FC, 0xFE0F⟆ ◼️ E0.6 black medium square";
## 25FB FE0F                                  ; fully-qualified     # ◻️ E0.6 white medium square # emoji-test.txt line #4143 Emoji version 13.0
is Uni.new(0x25FB, 0xFE0F).Str.chars, 1, "Codes: ⟅0x25FB, 0xFE0F⟆ ◻️ E0.6 white medium square";
## 25AA FE0F                                  ; fully-qualified     # ▪️ E0.6 black small square # emoji-test.txt line #4147 Emoji version 13.0
is Uni.new(0x25AA, 0xFE0F).Str.chars, 1, "Codes: ⟅0x25AA, 0xFE0F⟆ ▪️ E0.6 black small square";
## 25AB FE0F                                  ; fully-qualified     # ▫️ E0.6 white small square # emoji-test.txt line #4149 Emoji version 13.0
is Uni.new(0x25AB, 0xFE0F).Str.chars, 1, "Codes: ⟅0x25AB, 0xFE0F⟆ ▫️ E0.6 white small square";
## 1F3F3 FE0F                                 ; fully-qualified     # 🏳️ E0.7 white flag # emoji-test.txt line #4172 Emoji version 13.0
is Uni.new(0x1F3F3, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3F3, 0xFE0F⟆ 🏳️ E0.7 white flag";
## 1F3F3 FE0F 200D 1F308                      ; fully-qualified     # 🏳️‍🌈 E4.0 rainbow flag # emoji-test.txt line #4174 Emoji version 13.0
is Uni.new(0x1F3F3, 0xFE0F, 0x200D, 0x1F308).Str.chars, 1, "Codes: ⟅0x1F3F3, 0xFE0F, 0x200D, 0x1F308⟆ 🏳️‍🌈 E4.0 rainbow flag";
## 1F3F3 200D 1F308                           ; unqualified         # 🏳‍🌈 E4.0 rainbow flag # emoji-test.txt line #4175 Emoji version 13.0
is Uni.new(0x1F3F3, 0x200D, 0x1F308).Str.chars, 1, "Codes: ⟅0x1F3F3, 0x200D, 0x1F308⟆ 🏳‍🌈 E4.0 rainbow flag";
## 1F3F3 FE0F 200D 26A7 FE0F                  ; fully-qualified     # 🏳️‍⚧️ E13.0 transgender flag # emoji-test.txt line #4176 Emoji version 13.0
is Uni.new(0x1F3F3, 0xFE0F, 0x200D, 0x26A7, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3F3, 0xFE0F, 0x200D, 0x26A7, 0xFE0F⟆ 🏳️‍⚧️ E13.0 transgender flag";
## 1F3F3 200D 26A7 FE0F                       ; unqualified         # 🏳‍⚧️ E13.0 transgender flag # emoji-test.txt line #4177 Emoji version 13.0
is Uni.new(0x1F3F3, 0x200D, 0x26A7, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3F3, 0x200D, 0x26A7, 0xFE0F⟆ 🏳‍⚧️ E13.0 transgender flag";
## 1F3F3 FE0F 200D 26A7                       ; unqualified         # 🏳️‍⚧ E13.0 transgender flag # emoji-test.txt line #4178 Emoji version 13.0
is Uni.new(0x1F3F3, 0xFE0F, 0x200D, 0x26A7).Str.chars, 1, "Codes: ⟅0x1F3F3, 0xFE0F, 0x200D, 0x26A7⟆ 🏳️‍⚧ E13.0 transgender flag";
## 1F3F3 200D 26A7                            ; unqualified         # 🏳‍⚧ E13.0 transgender flag # emoji-test.txt line #4179 Emoji version 13.0
is Uni.new(0x1F3F3, 0x200D, 0x26A7).Str.chars, 1, "Codes: ⟅0x1F3F3, 0x200D, 0x26A7⟆ 🏳‍⚧ E13.0 transgender flag";
## 1F3F4 200D 2620 FE0F                       ; fully-qualified     # 🏴‍☠️ E11.0 pirate flag # emoji-test.txt line #4180 Emoji version 13.0
is Uni.new(0x1F3F4, 0x200D, 0x2620, 0xFE0F).Str.chars, 1, "Codes: ⟅0x1F3F4, 0x200D, 0x2620, 0xFE0F⟆ 🏴‍☠️ E11.0 pirate flag";
## 1F3F4 200D 2620                            ; minimally-qualified # 🏴‍☠ E11.0 pirate flag # emoji-test.txt line #4181 Emoji version 13.0
is Uni.new(0x1F3F4, 0x200D, 0x2620).Str.chars, 1, "Codes: ⟅0x1F3F4, 0x200D, 0x2620⟆ 🏴‍☠ E11.0 pirate flag";
## 1F1E6 1F1E8                                ; fully-qualified     # 🇦🇨 E2.0 flag: Ascension Island # emoji-test.txt line #4184 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1E8).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1E8⟆ 🇦🇨 E2.0 flag: Ascension Island";
## 1F1E6 1F1E9                                ; fully-qualified     # 🇦🇩 E2.0 flag: Andorra # emoji-test.txt line #4185 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1E9).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1E9⟆ 🇦🇩 E2.0 flag: Andorra";
## 1F1E6 1F1EA                                ; fully-qualified     # 🇦🇪 E2.0 flag: United Arab Emirates # emoji-test.txt line #4186 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1EA⟆ 🇦🇪 E2.0 flag: United Arab Emirates";
## 1F1E6 1F1EB                                ; fully-qualified     # 🇦🇫 E2.0 flag: Afghanistan # emoji-test.txt line #4187 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1EB).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1EB⟆ 🇦🇫 E2.0 flag: Afghanistan";
## 1F1E6 1F1EC                                ; fully-qualified     # 🇦🇬 E2.0 flag: Antigua & Barbuda # emoji-test.txt line #4188 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1EC⟆ 🇦🇬 E2.0 flag: Antigua & Barbuda";
## 1F1E6 1F1EE                                ; fully-qualified     # 🇦🇮 E2.0 flag: Anguilla # emoji-test.txt line #4189 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1EE).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1EE⟆ 🇦🇮 E2.0 flag: Anguilla";
## 1F1E6 1F1F1                                ; fully-qualified     # 🇦🇱 E2.0 flag: Albania # emoji-test.txt line #4190 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1F1).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1F1⟆ 🇦🇱 E2.0 flag: Albania";
## 1F1E6 1F1F2                                ; fully-qualified     # 🇦🇲 E2.0 flag: Armenia # emoji-test.txt line #4191 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1F2⟆ 🇦🇲 E2.0 flag: Armenia";
## 1F1E6 1F1F4                                ; fully-qualified     # 🇦🇴 E2.0 flag: Angola # emoji-test.txt line #4192 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1F4⟆ 🇦🇴 E2.0 flag: Angola";
## 1F1E6 1F1F6                                ; fully-qualified     # 🇦🇶 E2.0 flag: Antarctica # emoji-test.txt line #4193 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1F6).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1F6⟆ 🇦🇶 E2.0 flag: Antarctica";
## 1F1E6 1F1F7                                ; fully-qualified     # 🇦🇷 E2.0 flag: Argentina # emoji-test.txt line #4194 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1F7⟆ 🇦🇷 E2.0 flag: Argentina";
## 1F1E6 1F1F8                                ; fully-qualified     # 🇦🇸 E2.0 flag: American Samoa # emoji-test.txt line #4195 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1F8⟆ 🇦🇸 E2.0 flag: American Samoa";
## 1F1E6 1F1F9                                ; fully-qualified     # 🇦🇹 E2.0 flag: Austria # emoji-test.txt line #4196 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1F9⟆ 🇦🇹 E2.0 flag: Austria";
## 1F1E6 1F1FA                                ; fully-qualified     # 🇦🇺 E2.0 flag: Australia # emoji-test.txt line #4197 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1FA).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1FA⟆ 🇦🇺 E2.0 flag: Australia";
## 1F1E6 1F1FC                                ; fully-qualified     # 🇦🇼 E2.0 flag: Aruba # emoji-test.txt line #4198 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1FC).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1FC⟆ 🇦🇼 E2.0 flag: Aruba";
## 1F1E6 1F1FD                                ; fully-qualified     # 🇦🇽 E2.0 flag: Åland Islands # emoji-test.txt line #4199 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1FD).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1FD⟆ 🇦🇽 E2.0 flag: Åland Islands";
## 1F1E6 1F1FF                                ; fully-qualified     # 🇦🇿 E2.0 flag: Azerbaijan # emoji-test.txt line #4200 Emoji version 13.0
is Uni.new(0x1F1E6, 0x1F1FF).Str.chars, 1, "Codes: ⟅0x1F1E6, 0x1F1FF⟆ 🇦🇿 E2.0 flag: Azerbaijan";
## 1F1E7 1F1E6                                ; fully-qualified     # 🇧🇦 E2.0 flag: Bosnia & Herzegovina # emoji-test.txt line #4201 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1E6⟆ 🇧🇦 E2.0 flag: Bosnia & Herzegovina";
## 1F1E7 1F1E7                                ; fully-qualified     # 🇧🇧 E2.0 flag: Barbados # emoji-test.txt line #4202 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1E7).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1E7⟆ 🇧🇧 E2.0 flag: Barbados";
## 1F1E7 1F1E9                                ; fully-qualified     # 🇧🇩 E2.0 flag: Bangladesh # emoji-test.txt line #4203 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1E9).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1E9⟆ 🇧🇩 E2.0 flag: Bangladesh";
## 1F1E7 1F1EA                                ; fully-qualified     # 🇧🇪 E2.0 flag: Belgium # emoji-test.txt line #4204 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1EA⟆ 🇧🇪 E2.0 flag: Belgium";
## 1F1E7 1F1EB                                ; fully-qualified     # 🇧🇫 E2.0 flag: Burkina Faso # emoji-test.txt line #4205 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1EB).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1EB⟆ 🇧🇫 E2.0 flag: Burkina Faso";
## 1F1E7 1F1EC                                ; fully-qualified     # 🇧🇬 E2.0 flag: Bulgaria # emoji-test.txt line #4206 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1EC⟆ 🇧🇬 E2.0 flag: Bulgaria";
## 1F1E7 1F1ED                                ; fully-qualified     # 🇧🇭 E2.0 flag: Bahrain # emoji-test.txt line #4207 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1ED).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1ED⟆ 🇧🇭 E2.0 flag: Bahrain";
## 1F1E7 1F1EE                                ; fully-qualified     # 🇧🇮 E2.0 flag: Burundi # emoji-test.txt line #4208 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1EE).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1EE⟆ 🇧🇮 E2.0 flag: Burundi";
## 1F1E7 1F1EF                                ; fully-qualified     # 🇧🇯 E2.0 flag: Benin # emoji-test.txt line #4209 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1EF).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1EF⟆ 🇧🇯 E2.0 flag: Benin";
## 1F1E7 1F1F1                                ; fully-qualified     # 🇧🇱 E2.0 flag: St. Barthélemy # emoji-test.txt line #4210 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1F1).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1F1⟆ 🇧🇱 E2.0 flag: St. Barthélemy";
## 1F1E7 1F1F2                                ; fully-qualified     # 🇧🇲 E2.0 flag: Bermuda # emoji-test.txt line #4211 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1F2⟆ 🇧🇲 E2.0 flag: Bermuda";
## 1F1E7 1F1F3                                ; fully-qualified     # 🇧🇳 E2.0 flag: Brunei # emoji-test.txt line #4212 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1F3⟆ 🇧🇳 E2.0 flag: Brunei";
## 1F1E7 1F1F4                                ; fully-qualified     # 🇧🇴 E2.0 flag: Bolivia # emoji-test.txt line #4213 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1F4⟆ 🇧🇴 E2.0 flag: Bolivia";
## 1F1E7 1F1F6                                ; fully-qualified     # 🇧🇶 E2.0 flag: Caribbean Netherlands # emoji-test.txt line #4214 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1F6).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1F6⟆ 🇧🇶 E2.0 flag: Caribbean Netherlands";
## 1F1E7 1F1F7                                ; fully-qualified     # 🇧🇷 E2.0 flag: Brazil # emoji-test.txt line #4215 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1F7⟆ 🇧🇷 E2.0 flag: Brazil";
## 1F1E7 1F1F8                                ; fully-qualified     # 🇧🇸 E2.0 flag: Bahamas # emoji-test.txt line #4216 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1F8⟆ 🇧🇸 E2.0 flag: Bahamas";
## 1F1E7 1F1F9                                ; fully-qualified     # 🇧🇹 E2.0 flag: Bhutan # emoji-test.txt line #4217 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1F9⟆ 🇧🇹 E2.0 flag: Bhutan";
## 1F1E7 1F1FB                                ; fully-qualified     # 🇧🇻 E2.0 flag: Bouvet Island # emoji-test.txt line #4218 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1FB).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1FB⟆ 🇧🇻 E2.0 flag: Bouvet Island";
## 1F1E7 1F1FC                                ; fully-qualified     # 🇧🇼 E2.0 flag: Botswana # emoji-test.txt line #4219 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1FC).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1FC⟆ 🇧🇼 E2.0 flag: Botswana";
## 1F1E7 1F1FE                                ; fully-qualified     # 🇧🇾 E2.0 flag: Belarus # emoji-test.txt line #4220 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1FE).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1FE⟆ 🇧🇾 E2.0 flag: Belarus";
## 1F1E7 1F1FF                                ; fully-qualified     # 🇧🇿 E2.0 flag: Belize # emoji-test.txt line #4221 Emoji version 13.0
is Uni.new(0x1F1E7, 0x1F1FF).Str.chars, 1, "Codes: ⟅0x1F1E7, 0x1F1FF⟆ 🇧🇿 E2.0 flag: Belize";
## 1F1E8 1F1E6                                ; fully-qualified     # 🇨🇦 E2.0 flag: Canada # emoji-test.txt line #4222 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1E6⟆ 🇨🇦 E2.0 flag: Canada";
## 1F1E8 1F1E8                                ; fully-qualified     # 🇨🇨 E2.0 flag: Cocos (Keeling) Islands # emoji-test.txt line #4223 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1E8).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1E8⟆ 🇨🇨 E2.0 flag: Cocos (Keeling) Islands";
## 1F1E8 1F1E9                                ; fully-qualified     # 🇨🇩 E2.0 flag: Congo - Kinshasa # emoji-test.txt line #4224 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1E9).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1E9⟆ 🇨🇩 E2.0 flag: Congo - Kinshasa";
## 1F1E8 1F1EB                                ; fully-qualified     # 🇨🇫 E2.0 flag: Central African Republic # emoji-test.txt line #4225 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1EB).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1EB⟆ 🇨🇫 E2.0 flag: Central African Republic";
## 1F1E8 1F1EC                                ; fully-qualified     # 🇨🇬 E2.0 flag: Congo - Brazzaville # emoji-test.txt line #4226 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1EC⟆ 🇨🇬 E2.0 flag: Congo - Brazzaville";
## 1F1E8 1F1ED                                ; fully-qualified     # 🇨🇭 E2.0 flag: Switzerland # emoji-test.txt line #4227 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1ED).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1ED⟆ 🇨🇭 E2.0 flag: Switzerland";
## 1F1E8 1F1EE                                ; fully-qualified     # 🇨🇮 E2.0 flag: Côte d’Ivoire # emoji-test.txt line #4228 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1EE).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1EE⟆ 🇨🇮 E2.0 flag: Côte d’Ivoire";
## 1F1E8 1F1F0                                ; fully-qualified     # 🇨🇰 E2.0 flag: Cook Islands # emoji-test.txt line #4229 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1F0).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1F0⟆ 🇨🇰 E2.0 flag: Cook Islands";
## 1F1E8 1F1F1                                ; fully-qualified     # 🇨🇱 E2.0 flag: Chile # emoji-test.txt line #4230 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1F1).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1F1⟆ 🇨🇱 E2.0 flag: Chile";
## 1F1E8 1F1F2                                ; fully-qualified     # 🇨🇲 E2.0 flag: Cameroon # emoji-test.txt line #4231 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1F2⟆ 🇨🇲 E2.0 flag: Cameroon";
## 1F1E8 1F1F3                                ; fully-qualified     # 🇨🇳 E0.6 flag: China # emoji-test.txt line #4232 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1F3⟆ 🇨🇳 E0.6 flag: China";
## 1F1E8 1F1F4                                ; fully-qualified     # 🇨🇴 E2.0 flag: Colombia # emoji-test.txt line #4233 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1F4⟆ 🇨🇴 E2.0 flag: Colombia";
## 1F1E8 1F1F5                                ; fully-qualified     # 🇨🇵 E2.0 flag: Clipperton Island # emoji-test.txt line #4234 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1F5).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1F5⟆ 🇨🇵 E2.0 flag: Clipperton Island";
## 1F1E8 1F1F7                                ; fully-qualified     # 🇨🇷 E2.0 flag: Costa Rica # emoji-test.txt line #4235 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1F7⟆ 🇨🇷 E2.0 flag: Costa Rica";
## 1F1E8 1F1FA                                ; fully-qualified     # 🇨🇺 E2.0 flag: Cuba # emoji-test.txt line #4236 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1FA).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1FA⟆ 🇨🇺 E2.0 flag: Cuba";
## 1F1E8 1F1FB                                ; fully-qualified     # 🇨🇻 E2.0 flag: Cape Verde # emoji-test.txt line #4237 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1FB).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1FB⟆ 🇨🇻 E2.0 flag: Cape Verde";
## 1F1E8 1F1FC                                ; fully-qualified     # 🇨🇼 E2.0 flag: Curaçao # emoji-test.txt line #4238 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1FC).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1FC⟆ 🇨🇼 E2.0 flag: Curaçao";
## 1F1E8 1F1FD                                ; fully-qualified     # 🇨🇽 E2.0 flag: Christmas Island # emoji-test.txt line #4239 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1FD).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1FD⟆ 🇨🇽 E2.0 flag: Christmas Island";
## 1F1E8 1F1FE                                ; fully-qualified     # 🇨🇾 E2.0 flag: Cyprus # emoji-test.txt line #4240 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1FE).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1FE⟆ 🇨🇾 E2.0 flag: Cyprus";
## 1F1E8 1F1FF                                ; fully-qualified     # 🇨🇿 E2.0 flag: Czechia # emoji-test.txt line #4241 Emoji version 13.0
is Uni.new(0x1F1E8, 0x1F1FF).Str.chars, 1, "Codes: ⟅0x1F1E8, 0x1F1FF⟆ 🇨🇿 E2.0 flag: Czechia";
## 1F1E9 1F1EA                                ; fully-qualified     # 🇩🇪 E0.6 flag: Germany # emoji-test.txt line #4242 Emoji version 13.0
is Uni.new(0x1F1E9, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1E9, 0x1F1EA⟆ 🇩🇪 E0.6 flag: Germany";
## 1F1E9 1F1EC                                ; fully-qualified     # 🇩🇬 E2.0 flag: Diego Garcia # emoji-test.txt line #4243 Emoji version 13.0
is Uni.new(0x1F1E9, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1E9, 0x1F1EC⟆ 🇩🇬 E2.0 flag: Diego Garcia";
## 1F1E9 1F1EF                                ; fully-qualified     # 🇩🇯 E2.0 flag: Djibouti # emoji-test.txt line #4244 Emoji version 13.0
is Uni.new(0x1F1E9, 0x1F1EF).Str.chars, 1, "Codes: ⟅0x1F1E9, 0x1F1EF⟆ 🇩🇯 E2.0 flag: Djibouti";
## 1F1E9 1F1F0                                ; fully-qualified     # 🇩🇰 E2.0 flag: Denmark # emoji-test.txt line #4245 Emoji version 13.0
is Uni.new(0x1F1E9, 0x1F1F0).Str.chars, 1, "Codes: ⟅0x1F1E9, 0x1F1F0⟆ 🇩🇰 E2.0 flag: Denmark";
## 1F1E9 1F1F2                                ; fully-qualified     # 🇩🇲 E2.0 flag: Dominica # emoji-test.txt line #4246 Emoji version 13.0
is Uni.new(0x1F1E9, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1E9, 0x1F1F2⟆ 🇩🇲 E2.0 flag: Dominica";
## 1F1E9 1F1F4                                ; fully-qualified     # 🇩🇴 E2.0 flag: Dominican Republic # emoji-test.txt line #4247 Emoji version 13.0
is Uni.new(0x1F1E9, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1E9, 0x1F1F4⟆ 🇩🇴 E2.0 flag: Dominican Republic";
## 1F1E9 1F1FF                                ; fully-qualified     # 🇩🇿 E2.0 flag: Algeria # emoji-test.txt line #4248 Emoji version 13.0
is Uni.new(0x1F1E9, 0x1F1FF).Str.chars, 1, "Codes: ⟅0x1F1E9, 0x1F1FF⟆ 🇩🇿 E2.0 flag: Algeria";
## 1F1EA 1F1E6                                ; fully-qualified     # 🇪🇦 E2.0 flag: Ceuta & Melilla # emoji-test.txt line #4249 Emoji version 13.0
is Uni.new(0x1F1EA, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1EA, 0x1F1E6⟆ 🇪🇦 E2.0 flag: Ceuta & Melilla";
## 1F1EA 1F1E8                                ; fully-qualified     # 🇪🇨 E2.0 flag: Ecuador # emoji-test.txt line #4250 Emoji version 13.0
is Uni.new(0x1F1EA, 0x1F1E8).Str.chars, 1, "Codes: ⟅0x1F1EA, 0x1F1E8⟆ 🇪🇨 E2.0 flag: Ecuador";
## 1F1EA 1F1EA                                ; fully-qualified     # 🇪🇪 E2.0 flag: Estonia # emoji-test.txt line #4251 Emoji version 13.0
is Uni.new(0x1F1EA, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1EA, 0x1F1EA⟆ 🇪🇪 E2.0 flag: Estonia";
## 1F1EA 1F1EC                                ; fully-qualified     # 🇪🇬 E2.0 flag: Egypt # emoji-test.txt line #4252 Emoji version 13.0
is Uni.new(0x1F1EA, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1EA, 0x1F1EC⟆ 🇪🇬 E2.0 flag: Egypt";
## 1F1EA 1F1ED                                ; fully-qualified     # 🇪🇭 E2.0 flag: Western Sahara # emoji-test.txt line #4253 Emoji version 13.0
is Uni.new(0x1F1EA, 0x1F1ED).Str.chars, 1, "Codes: ⟅0x1F1EA, 0x1F1ED⟆ 🇪🇭 E2.0 flag: Western Sahara";
## 1F1EA 1F1F7                                ; fully-qualified     # 🇪🇷 E2.0 flag: Eritrea # emoji-test.txt line #4254 Emoji version 13.0
is Uni.new(0x1F1EA, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1EA, 0x1F1F7⟆ 🇪🇷 E2.0 flag: Eritrea";
## 1F1EA 1F1F8                                ; fully-qualified     # 🇪🇸 E0.6 flag: Spain # emoji-test.txt line #4255 Emoji version 13.0
is Uni.new(0x1F1EA, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1EA, 0x1F1F8⟆ 🇪🇸 E0.6 flag: Spain";
## 1F1EA 1F1F9                                ; fully-qualified     # 🇪🇹 E2.0 flag: Ethiopia # emoji-test.txt line #4256 Emoji version 13.0
is Uni.new(0x1F1EA, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1EA, 0x1F1F9⟆ 🇪🇹 E2.0 flag: Ethiopia";
## 1F1EA 1F1FA                                ; fully-qualified     # 🇪🇺 E2.0 flag: European Union # emoji-test.txt line #4257 Emoji version 13.0
is Uni.new(0x1F1EA, 0x1F1FA).Str.chars, 1, "Codes: ⟅0x1F1EA, 0x1F1FA⟆ 🇪🇺 E2.0 flag: European Union";
## 1F1EB 1F1EE                                ; fully-qualified     # 🇫🇮 E2.0 flag: Finland # emoji-test.txt line #4258 Emoji version 13.0
is Uni.new(0x1F1EB, 0x1F1EE).Str.chars, 1, "Codes: ⟅0x1F1EB, 0x1F1EE⟆ 🇫🇮 E2.0 flag: Finland";
## 1F1EB 1F1EF                                ; fully-qualified     # 🇫🇯 E2.0 flag: Fiji # emoji-test.txt line #4259 Emoji version 13.0
is Uni.new(0x1F1EB, 0x1F1EF).Str.chars, 1, "Codes: ⟅0x1F1EB, 0x1F1EF⟆ 🇫🇯 E2.0 flag: Fiji";
## 1F1EB 1F1F0                                ; fully-qualified     # 🇫🇰 E2.0 flag: Falkland Islands # emoji-test.txt line #4260 Emoji version 13.0
is Uni.new(0x1F1EB, 0x1F1F0).Str.chars, 1, "Codes: ⟅0x1F1EB, 0x1F1F0⟆ 🇫🇰 E2.0 flag: Falkland Islands";
## 1F1EB 1F1F2                                ; fully-qualified     # 🇫🇲 E2.0 flag: Micronesia # emoji-test.txt line #4261 Emoji version 13.0
is Uni.new(0x1F1EB, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1EB, 0x1F1F2⟆ 🇫🇲 E2.0 flag: Micronesia";
## 1F1EB 1F1F4                                ; fully-qualified     # 🇫🇴 E2.0 flag: Faroe Islands # emoji-test.txt line #4262 Emoji version 13.0
is Uni.new(0x1F1EB, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1EB, 0x1F1F4⟆ 🇫🇴 E2.0 flag: Faroe Islands";
## 1F1EB 1F1F7                                ; fully-qualified     # 🇫🇷 E0.6 flag: France # emoji-test.txt line #4263 Emoji version 13.0
is Uni.new(0x1F1EB, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1EB, 0x1F1F7⟆ 🇫🇷 E0.6 flag: France";
## 1F1EC 1F1E6                                ; fully-qualified     # 🇬🇦 E2.0 flag: Gabon # emoji-test.txt line #4264 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1E6⟆ 🇬🇦 E2.0 flag: Gabon";
## 1F1EC 1F1E7                                ; fully-qualified     # 🇬🇧 E0.6 flag: United Kingdom # emoji-test.txt line #4265 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1E7).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1E7⟆ 🇬🇧 E0.6 flag: United Kingdom";
## 1F1EC 1F1E9                                ; fully-qualified     # 🇬🇩 E2.0 flag: Grenada # emoji-test.txt line #4266 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1E9).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1E9⟆ 🇬🇩 E2.0 flag: Grenada";
## 1F1EC 1F1EA                                ; fully-qualified     # 🇬🇪 E2.0 flag: Georgia # emoji-test.txt line #4267 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1EA⟆ 🇬🇪 E2.0 flag: Georgia";
## 1F1EC 1F1EB                                ; fully-qualified     # 🇬🇫 E2.0 flag: French Guiana # emoji-test.txt line #4268 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1EB).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1EB⟆ 🇬🇫 E2.0 flag: French Guiana";
## 1F1EC 1F1EC                                ; fully-qualified     # 🇬🇬 E2.0 flag: Guernsey # emoji-test.txt line #4269 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1EC⟆ 🇬🇬 E2.0 flag: Guernsey";
## 1F1EC 1F1ED                                ; fully-qualified     # 🇬🇭 E2.0 flag: Ghana # emoji-test.txt line #4270 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1ED).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1ED⟆ 🇬🇭 E2.0 flag: Ghana";
## 1F1EC 1F1EE                                ; fully-qualified     # 🇬🇮 E2.0 flag: Gibraltar # emoji-test.txt line #4271 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1EE).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1EE⟆ 🇬🇮 E2.0 flag: Gibraltar";
## 1F1EC 1F1F1                                ; fully-qualified     # 🇬🇱 E2.0 flag: Greenland # emoji-test.txt line #4272 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1F1).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1F1⟆ 🇬🇱 E2.0 flag: Greenland";
## 1F1EC 1F1F2                                ; fully-qualified     # 🇬🇲 E2.0 flag: Gambia # emoji-test.txt line #4273 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1F2⟆ 🇬🇲 E2.0 flag: Gambia";
## 1F1EC 1F1F3                                ; fully-qualified     # 🇬🇳 E2.0 flag: Guinea # emoji-test.txt line #4274 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1F3⟆ 🇬🇳 E2.0 flag: Guinea";
## 1F1EC 1F1F5                                ; fully-qualified     # 🇬🇵 E2.0 flag: Guadeloupe # emoji-test.txt line #4275 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1F5).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1F5⟆ 🇬🇵 E2.0 flag: Guadeloupe";
## 1F1EC 1F1F6                                ; fully-qualified     # 🇬🇶 E2.0 flag: Equatorial Guinea # emoji-test.txt line #4276 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1F6).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1F6⟆ 🇬🇶 E2.0 flag: Equatorial Guinea";
## 1F1EC 1F1F7                                ; fully-qualified     # 🇬🇷 E2.0 flag: Greece # emoji-test.txt line #4277 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1F7⟆ 🇬🇷 E2.0 flag: Greece";
## 1F1EC 1F1F8                                ; fully-qualified     # 🇬🇸 E2.0 flag: South Georgia & South Sandwich Islands # emoji-test.txt line #4278 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1F8⟆ 🇬🇸 E2.0 flag: South Georgia & South Sandwich Islands";
## 1F1EC 1F1F9                                ; fully-qualified     # 🇬🇹 E2.0 flag: Guatemala # emoji-test.txt line #4279 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1F9⟆ 🇬🇹 E2.0 flag: Guatemala";
## 1F1EC 1F1FA                                ; fully-qualified     # 🇬🇺 E2.0 flag: Guam # emoji-test.txt line #4280 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1FA).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1FA⟆ 🇬🇺 E2.0 flag: Guam";
## 1F1EC 1F1FC                                ; fully-qualified     # 🇬🇼 E2.0 flag: Guinea-Bissau # emoji-test.txt line #4281 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1FC).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1FC⟆ 🇬🇼 E2.0 flag: Guinea-Bissau";
## 1F1EC 1F1FE                                ; fully-qualified     # 🇬🇾 E2.0 flag: Guyana # emoji-test.txt line #4282 Emoji version 13.0
is Uni.new(0x1F1EC, 0x1F1FE).Str.chars, 1, "Codes: ⟅0x1F1EC, 0x1F1FE⟆ 🇬🇾 E2.0 flag: Guyana";
## 1F1ED 1F1F0                                ; fully-qualified     # 🇭🇰 E2.0 flag: Hong Kong SAR China # emoji-test.txt line #4283 Emoji version 13.0
is Uni.new(0x1F1ED, 0x1F1F0).Str.chars, 1, "Codes: ⟅0x1F1ED, 0x1F1F0⟆ 🇭🇰 E2.0 flag: Hong Kong SAR China";
## 1F1ED 1F1F2                                ; fully-qualified     # 🇭🇲 E2.0 flag: Heard & McDonald Islands # emoji-test.txt line #4284 Emoji version 13.0
is Uni.new(0x1F1ED, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1ED, 0x1F1F2⟆ 🇭🇲 E2.0 flag: Heard & McDonald Islands";
## 1F1ED 1F1F3                                ; fully-qualified     # 🇭🇳 E2.0 flag: Honduras # emoji-test.txt line #4285 Emoji version 13.0
is Uni.new(0x1F1ED, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1ED, 0x1F1F3⟆ 🇭🇳 E2.0 flag: Honduras";
## 1F1ED 1F1F7                                ; fully-qualified     # 🇭🇷 E2.0 flag: Croatia # emoji-test.txt line #4286 Emoji version 13.0
is Uni.new(0x1F1ED, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1ED, 0x1F1F7⟆ 🇭🇷 E2.0 flag: Croatia";
## 1F1ED 1F1F9                                ; fully-qualified     # 🇭🇹 E2.0 flag: Haiti # emoji-test.txt line #4287 Emoji version 13.0
is Uni.new(0x1F1ED, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1ED, 0x1F1F9⟆ 🇭🇹 E2.0 flag: Haiti";
## 1F1ED 1F1FA                                ; fully-qualified     # 🇭🇺 E2.0 flag: Hungary # emoji-test.txt line #4288 Emoji version 13.0
is Uni.new(0x1F1ED, 0x1F1FA).Str.chars, 1, "Codes: ⟅0x1F1ED, 0x1F1FA⟆ 🇭🇺 E2.0 flag: Hungary";
## 1F1EE 1F1E8                                ; fully-qualified     # 🇮🇨 E2.0 flag: Canary Islands # emoji-test.txt line #4289 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1E8).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1E8⟆ 🇮🇨 E2.0 flag: Canary Islands";
## 1F1EE 1F1E9                                ; fully-qualified     # 🇮🇩 E2.0 flag: Indonesia # emoji-test.txt line #4290 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1E9).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1E9⟆ 🇮🇩 E2.0 flag: Indonesia";
## 1F1EE 1F1EA                                ; fully-qualified     # 🇮🇪 E2.0 flag: Ireland # emoji-test.txt line #4291 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1EA⟆ 🇮🇪 E2.0 flag: Ireland";
## 1F1EE 1F1F1                                ; fully-qualified     # 🇮🇱 E2.0 flag: Israel # emoji-test.txt line #4292 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1F1).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1F1⟆ 🇮🇱 E2.0 flag: Israel";
## 1F1EE 1F1F2                                ; fully-qualified     # 🇮🇲 E2.0 flag: Isle of Man # emoji-test.txt line #4293 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1F2⟆ 🇮🇲 E2.0 flag: Isle of Man";
## 1F1EE 1F1F3                                ; fully-qualified     # 🇮🇳 E2.0 flag: India # emoji-test.txt line #4294 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1F3⟆ 🇮🇳 E2.0 flag: India";
## 1F1EE 1F1F4                                ; fully-qualified     # 🇮🇴 E2.0 flag: British Indian Ocean Territory # emoji-test.txt line #4295 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1F4⟆ 🇮🇴 E2.0 flag: British Indian Ocean Territory";
## 1F1EE 1F1F6                                ; fully-qualified     # 🇮🇶 E2.0 flag: Iraq # emoji-test.txt line #4296 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1F6).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1F6⟆ 🇮🇶 E2.0 flag: Iraq";
## 1F1EE 1F1F7                                ; fully-qualified     # 🇮🇷 E2.0 flag: Iran # emoji-test.txt line #4297 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1F7⟆ 🇮🇷 E2.0 flag: Iran";
## 1F1EE 1F1F8                                ; fully-qualified     # 🇮🇸 E2.0 flag: Iceland # emoji-test.txt line #4298 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1F8⟆ 🇮🇸 E2.0 flag: Iceland";
## 1F1EE 1F1F9                                ; fully-qualified     # 🇮🇹 E0.6 flag: Italy # emoji-test.txt line #4299 Emoji version 13.0
is Uni.new(0x1F1EE, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1EE, 0x1F1F9⟆ 🇮🇹 E0.6 flag: Italy";
## 1F1EF 1F1EA                                ; fully-qualified     # 🇯🇪 E2.0 flag: Jersey # emoji-test.txt line #4300 Emoji version 13.0
is Uni.new(0x1F1EF, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1EF, 0x1F1EA⟆ 🇯🇪 E2.0 flag: Jersey";
## 1F1EF 1F1F2                                ; fully-qualified     # 🇯🇲 E2.0 flag: Jamaica # emoji-test.txt line #4301 Emoji version 13.0
is Uni.new(0x1F1EF, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1EF, 0x1F1F2⟆ 🇯🇲 E2.0 flag: Jamaica";
## 1F1EF 1F1F4                                ; fully-qualified     # 🇯🇴 E2.0 flag: Jordan # emoji-test.txt line #4302 Emoji version 13.0
is Uni.new(0x1F1EF, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1EF, 0x1F1F4⟆ 🇯🇴 E2.0 flag: Jordan";
## 1F1EF 1F1F5                                ; fully-qualified     # 🇯🇵 E0.6 flag: Japan # emoji-test.txt line #4303 Emoji version 13.0
is Uni.new(0x1F1EF, 0x1F1F5).Str.chars, 1, "Codes: ⟅0x1F1EF, 0x1F1F5⟆ 🇯🇵 E0.6 flag: Japan";
## 1F1F0 1F1EA                                ; fully-qualified     # 🇰🇪 E2.0 flag: Kenya # emoji-test.txt line #4304 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1EA⟆ 🇰🇪 E2.0 flag: Kenya";
## 1F1F0 1F1EC                                ; fully-qualified     # 🇰🇬 E2.0 flag: Kyrgyzstan # emoji-test.txt line #4305 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1EC⟆ 🇰🇬 E2.0 flag: Kyrgyzstan";
## 1F1F0 1F1ED                                ; fully-qualified     # 🇰🇭 E2.0 flag: Cambodia # emoji-test.txt line #4306 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1ED).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1ED⟆ 🇰🇭 E2.0 flag: Cambodia";
## 1F1F0 1F1EE                                ; fully-qualified     # 🇰🇮 E2.0 flag: Kiribati # emoji-test.txt line #4307 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1EE).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1EE⟆ 🇰🇮 E2.0 flag: Kiribati";
## 1F1F0 1F1F2                                ; fully-qualified     # 🇰🇲 E2.0 flag: Comoros # emoji-test.txt line #4308 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1F2⟆ 🇰🇲 E2.0 flag: Comoros";
## 1F1F0 1F1F3                                ; fully-qualified     # 🇰🇳 E2.0 flag: St. Kitts & Nevis # emoji-test.txt line #4309 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1F3⟆ 🇰🇳 E2.0 flag: St. Kitts & Nevis";
## 1F1F0 1F1F5                                ; fully-qualified     # 🇰🇵 E2.0 flag: North Korea # emoji-test.txt line #4310 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1F5).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1F5⟆ 🇰🇵 E2.0 flag: North Korea";
## 1F1F0 1F1F7                                ; fully-qualified     # 🇰🇷 E0.6 flag: South Korea # emoji-test.txt line #4311 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1F7⟆ 🇰🇷 E0.6 flag: South Korea";
## 1F1F0 1F1FC                                ; fully-qualified     # 🇰🇼 E2.0 flag: Kuwait # emoji-test.txt line #4312 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1FC).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1FC⟆ 🇰🇼 E2.0 flag: Kuwait";
## 1F1F0 1F1FE                                ; fully-qualified     # 🇰🇾 E2.0 flag: Cayman Islands # emoji-test.txt line #4313 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1FE).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1FE⟆ 🇰🇾 E2.0 flag: Cayman Islands";
## 1F1F0 1F1FF                                ; fully-qualified     # 🇰🇿 E2.0 flag: Kazakhstan # emoji-test.txt line #4314 Emoji version 13.0
is Uni.new(0x1F1F0, 0x1F1FF).Str.chars, 1, "Codes: ⟅0x1F1F0, 0x1F1FF⟆ 🇰🇿 E2.0 flag: Kazakhstan";
## 1F1F1 1F1E6                                ; fully-qualified     # 🇱🇦 E2.0 flag: Laos # emoji-test.txt line #4315 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1E6⟆ 🇱🇦 E2.0 flag: Laos";
## 1F1F1 1F1E7                                ; fully-qualified     # 🇱🇧 E2.0 flag: Lebanon # emoji-test.txt line #4316 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1E7).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1E7⟆ 🇱🇧 E2.0 flag: Lebanon";
## 1F1F1 1F1E8                                ; fully-qualified     # 🇱🇨 E2.0 flag: St. Lucia # emoji-test.txt line #4317 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1E8).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1E8⟆ 🇱🇨 E2.0 flag: St. Lucia";
## 1F1F1 1F1EE                                ; fully-qualified     # 🇱🇮 E2.0 flag: Liechtenstein # emoji-test.txt line #4318 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1EE).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1EE⟆ 🇱🇮 E2.0 flag: Liechtenstein";
## 1F1F1 1F1F0                                ; fully-qualified     # 🇱🇰 E2.0 flag: Sri Lanka # emoji-test.txt line #4319 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1F0).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1F0⟆ 🇱🇰 E2.0 flag: Sri Lanka";
## 1F1F1 1F1F7                                ; fully-qualified     # 🇱🇷 E2.0 flag: Liberia # emoji-test.txt line #4320 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1F7⟆ 🇱🇷 E2.0 flag: Liberia";
## 1F1F1 1F1F8                                ; fully-qualified     # 🇱🇸 E2.0 flag: Lesotho # emoji-test.txt line #4321 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1F8⟆ 🇱🇸 E2.0 flag: Lesotho";
## 1F1F1 1F1F9                                ; fully-qualified     # 🇱🇹 E2.0 flag: Lithuania # emoji-test.txt line #4322 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1F9⟆ 🇱🇹 E2.0 flag: Lithuania";
## 1F1F1 1F1FA                                ; fully-qualified     # 🇱🇺 E2.0 flag: Luxembourg # emoji-test.txt line #4323 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1FA).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1FA⟆ 🇱🇺 E2.0 flag: Luxembourg";
## 1F1F1 1F1FB                                ; fully-qualified     # 🇱🇻 E2.0 flag: Latvia # emoji-test.txt line #4324 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1FB).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1FB⟆ 🇱🇻 E2.0 flag: Latvia";
## 1F1F1 1F1FE                                ; fully-qualified     # 🇱🇾 E2.0 flag: Libya # emoji-test.txt line #4325 Emoji version 13.0
is Uni.new(0x1F1F1, 0x1F1FE).Str.chars, 1, "Codes: ⟅0x1F1F1, 0x1F1FE⟆ 🇱🇾 E2.0 flag: Libya";
## 1F1F2 1F1E6                                ; fully-qualified     # 🇲🇦 E2.0 flag: Morocco # emoji-test.txt line #4326 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1E6⟆ 🇲🇦 E2.0 flag: Morocco";
## 1F1F2 1F1E8                                ; fully-qualified     # 🇲🇨 E2.0 flag: Monaco # emoji-test.txt line #4327 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1E8).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1E8⟆ 🇲🇨 E2.0 flag: Monaco";
## 1F1F2 1F1E9                                ; fully-qualified     # 🇲🇩 E2.0 flag: Moldova # emoji-test.txt line #4328 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1E9).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1E9⟆ 🇲🇩 E2.0 flag: Moldova";
## 1F1F2 1F1EA                                ; fully-qualified     # 🇲🇪 E2.0 flag: Montenegro # emoji-test.txt line #4329 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1EA⟆ 🇲🇪 E2.0 flag: Montenegro";
## 1F1F2 1F1EB                                ; fully-qualified     # 🇲🇫 E2.0 flag: St. Martin # emoji-test.txt line #4330 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1EB).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1EB⟆ 🇲🇫 E2.0 flag: St. Martin";
## 1F1F2 1F1EC                                ; fully-qualified     # 🇲🇬 E2.0 flag: Madagascar # emoji-test.txt line #4331 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1EC⟆ 🇲🇬 E2.0 flag: Madagascar";
## 1F1F2 1F1ED                                ; fully-qualified     # 🇲🇭 E2.0 flag: Marshall Islands # emoji-test.txt line #4332 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1ED).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1ED⟆ 🇲🇭 E2.0 flag: Marshall Islands";
## 1F1F2 1F1F0                                ; fully-qualified     # 🇲🇰 E2.0 flag: North Macedonia # emoji-test.txt line #4333 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1F0).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1F0⟆ 🇲🇰 E2.0 flag: North Macedonia";
## 1F1F2 1F1F1                                ; fully-qualified     # 🇲🇱 E2.0 flag: Mali # emoji-test.txt line #4334 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1F1).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1F1⟆ 🇲🇱 E2.0 flag: Mali";
## 1F1F2 1F1F2                                ; fully-qualified     # 🇲🇲 E2.0 flag: Myanmar (Burma) # emoji-test.txt line #4335 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1F2⟆ 🇲🇲 E2.0 flag: Myanmar (Burma)";
## 1F1F2 1F1F3                                ; fully-qualified     # 🇲🇳 E2.0 flag: Mongolia # emoji-test.txt line #4336 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1F3⟆ 🇲🇳 E2.0 flag: Mongolia";
## 1F1F2 1F1F4                                ; fully-qualified     # 🇲🇴 E2.0 flag: Macao SAR China # emoji-test.txt line #4337 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1F4⟆ 🇲🇴 E2.0 flag: Macao SAR China";
## 1F1F2 1F1F5                                ; fully-qualified     # 🇲🇵 E2.0 flag: Northern Mariana Islands # emoji-test.txt line #4338 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1F5).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1F5⟆ 🇲🇵 E2.0 flag: Northern Mariana Islands";
## 1F1F2 1F1F6                                ; fully-qualified     # 🇲🇶 E2.0 flag: Martinique # emoji-test.txt line #4339 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1F6).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1F6⟆ 🇲🇶 E2.0 flag: Martinique";
## 1F1F2 1F1F7                                ; fully-qualified     # 🇲🇷 E2.0 flag: Mauritania # emoji-test.txt line #4340 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1F7⟆ 🇲🇷 E2.0 flag: Mauritania";
## 1F1F2 1F1F8                                ; fully-qualified     # 🇲🇸 E2.0 flag: Montserrat # emoji-test.txt line #4341 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1F8⟆ 🇲🇸 E2.0 flag: Montserrat";
## 1F1F2 1F1F9                                ; fully-qualified     # 🇲🇹 E2.0 flag: Malta # emoji-test.txt line #4342 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1F9⟆ 🇲🇹 E2.0 flag: Malta";
## 1F1F2 1F1FA                                ; fully-qualified     # 🇲🇺 E2.0 flag: Mauritius # emoji-test.txt line #4343 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1FA).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1FA⟆ 🇲🇺 E2.0 flag: Mauritius";
## 1F1F2 1F1FB                                ; fully-qualified     # 🇲🇻 E2.0 flag: Maldives # emoji-test.txt line #4344 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1FB).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1FB⟆ 🇲🇻 E2.0 flag: Maldives";
## 1F1F2 1F1FC                                ; fully-qualified     # 🇲🇼 E2.0 flag: Malawi # emoji-test.txt line #4345 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1FC).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1FC⟆ 🇲🇼 E2.0 flag: Malawi";
## 1F1F2 1F1FD                                ; fully-qualified     # 🇲🇽 E2.0 flag: Mexico # emoji-test.txt line #4346 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1FD).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1FD⟆ 🇲🇽 E2.0 flag: Mexico";
## 1F1F2 1F1FE                                ; fully-qualified     # 🇲🇾 E2.0 flag: Malaysia # emoji-test.txt line #4347 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1FE).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1FE⟆ 🇲🇾 E2.0 flag: Malaysia";
## 1F1F2 1F1FF                                ; fully-qualified     # 🇲🇿 E2.0 flag: Mozambique # emoji-test.txt line #4348 Emoji version 13.0
is Uni.new(0x1F1F2, 0x1F1FF).Str.chars, 1, "Codes: ⟅0x1F1F2, 0x1F1FF⟆ 🇲🇿 E2.0 flag: Mozambique";
## 1F1F3 1F1E6                                ; fully-qualified     # 🇳🇦 E2.0 flag: Namibia # emoji-test.txt line #4349 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1E6⟆ 🇳🇦 E2.0 flag: Namibia";
## 1F1F3 1F1E8                                ; fully-qualified     # 🇳🇨 E2.0 flag: New Caledonia # emoji-test.txt line #4350 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1E8).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1E8⟆ 🇳🇨 E2.0 flag: New Caledonia";
## 1F1F3 1F1EA                                ; fully-qualified     # 🇳🇪 E2.0 flag: Niger # emoji-test.txt line #4351 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1EA⟆ 🇳🇪 E2.0 flag: Niger";
## 1F1F3 1F1EB                                ; fully-qualified     # 🇳🇫 E2.0 flag: Norfolk Island # emoji-test.txt line #4352 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1EB).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1EB⟆ 🇳🇫 E2.0 flag: Norfolk Island";
## 1F1F3 1F1EC                                ; fully-qualified     # 🇳🇬 E2.0 flag: Nigeria # emoji-test.txt line #4353 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1EC⟆ 🇳🇬 E2.0 flag: Nigeria";
## 1F1F3 1F1EE                                ; fully-qualified     # 🇳🇮 E2.0 flag: Nicaragua # emoji-test.txt line #4354 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1EE).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1EE⟆ 🇳🇮 E2.0 flag: Nicaragua";
## 1F1F3 1F1F1                                ; fully-qualified     # 🇳🇱 E2.0 flag: Netherlands # emoji-test.txt line #4355 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1F1).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1F1⟆ 🇳🇱 E2.0 flag: Netherlands";
## 1F1F3 1F1F4                                ; fully-qualified     # 🇳🇴 E2.0 flag: Norway # emoji-test.txt line #4356 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1F4⟆ 🇳🇴 E2.0 flag: Norway";
## 1F1F3 1F1F5                                ; fully-qualified     # 🇳🇵 E2.0 flag: Nepal # emoji-test.txt line #4357 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1F5).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1F5⟆ 🇳🇵 E2.0 flag: Nepal";
## 1F1F3 1F1F7                                ; fully-qualified     # 🇳🇷 E2.0 flag: Nauru # emoji-test.txt line #4358 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1F7⟆ 🇳🇷 E2.0 flag: Nauru";
## 1F1F3 1F1FA                                ; fully-qualified     # 🇳🇺 E2.0 flag: Niue # emoji-test.txt line #4359 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1FA).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1FA⟆ 🇳🇺 E2.0 flag: Niue";
## 1F1F3 1F1FF                                ; fully-qualified     # 🇳🇿 E2.0 flag: New Zealand # emoji-test.txt line #4360 Emoji version 13.0
is Uni.new(0x1F1F3, 0x1F1FF).Str.chars, 1, "Codes: ⟅0x1F1F3, 0x1F1FF⟆ 🇳🇿 E2.0 flag: New Zealand";
## 1F1F4 1F1F2                                ; fully-qualified     # 🇴🇲 E2.0 flag: Oman # emoji-test.txt line #4361 Emoji version 13.0
is Uni.new(0x1F1F4, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1F4, 0x1F1F2⟆ 🇴🇲 E2.0 flag: Oman";
## 1F1F5 1F1E6                                ; fully-qualified     # 🇵🇦 E2.0 flag: Panama # emoji-test.txt line #4362 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1E6⟆ 🇵🇦 E2.0 flag: Panama";
## 1F1F5 1F1EA                                ; fully-qualified     # 🇵🇪 E2.0 flag: Peru # emoji-test.txt line #4363 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1EA⟆ 🇵🇪 E2.0 flag: Peru";
## 1F1F5 1F1EB                                ; fully-qualified     # 🇵🇫 E2.0 flag: French Polynesia # emoji-test.txt line #4364 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1EB).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1EB⟆ 🇵🇫 E2.0 flag: French Polynesia";
## 1F1F5 1F1EC                                ; fully-qualified     # 🇵🇬 E2.0 flag: Papua New Guinea # emoji-test.txt line #4365 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1EC⟆ 🇵🇬 E2.0 flag: Papua New Guinea";
## 1F1F5 1F1ED                                ; fully-qualified     # 🇵🇭 E2.0 flag: Philippines # emoji-test.txt line #4366 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1ED).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1ED⟆ 🇵🇭 E2.0 flag: Philippines";
## 1F1F5 1F1F0                                ; fully-qualified     # 🇵🇰 E2.0 flag: Pakistan # emoji-test.txt line #4367 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1F0).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1F0⟆ 🇵🇰 E2.0 flag: Pakistan";
## 1F1F5 1F1F1                                ; fully-qualified     # 🇵🇱 E2.0 flag: Poland # emoji-test.txt line #4368 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1F1).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1F1⟆ 🇵🇱 E2.0 flag: Poland";
## 1F1F5 1F1F2                                ; fully-qualified     # 🇵🇲 E2.0 flag: St. Pierre & Miquelon # emoji-test.txt line #4369 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1F2⟆ 🇵🇲 E2.0 flag: St. Pierre & Miquelon";
## 1F1F5 1F1F3                                ; fully-qualified     # 🇵🇳 E2.0 flag: Pitcairn Islands # emoji-test.txt line #4370 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1F3⟆ 🇵🇳 E2.0 flag: Pitcairn Islands";
## 1F1F5 1F1F7                                ; fully-qualified     # 🇵🇷 E2.0 flag: Puerto Rico # emoji-test.txt line #4371 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1F7⟆ 🇵🇷 E2.0 flag: Puerto Rico";
## 1F1F5 1F1F8                                ; fully-qualified     # 🇵🇸 E2.0 flag: Palestinian Territories # emoji-test.txt line #4372 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1F8⟆ 🇵🇸 E2.0 flag: Palestinian Territories";
## 1F1F5 1F1F9                                ; fully-qualified     # 🇵🇹 E2.0 flag: Portugal # emoji-test.txt line #4373 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1F9⟆ 🇵🇹 E2.0 flag: Portugal";
## 1F1F5 1F1FC                                ; fully-qualified     # 🇵🇼 E2.0 flag: Palau # emoji-test.txt line #4374 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1FC).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1FC⟆ 🇵🇼 E2.0 flag: Palau";
## 1F1F5 1F1FE                                ; fully-qualified     # 🇵🇾 E2.0 flag: Paraguay # emoji-test.txt line #4375 Emoji version 13.0
is Uni.new(0x1F1F5, 0x1F1FE).Str.chars, 1, "Codes: ⟅0x1F1F5, 0x1F1FE⟆ 🇵🇾 E2.0 flag: Paraguay";
## 1F1F6 1F1E6                                ; fully-qualified     # 🇶🇦 E2.0 flag: Qatar # emoji-test.txt line #4376 Emoji version 13.0
is Uni.new(0x1F1F6, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1F6, 0x1F1E6⟆ 🇶🇦 E2.0 flag: Qatar";
## 1F1F7 1F1EA                                ; fully-qualified     # 🇷🇪 E2.0 flag: Réunion # emoji-test.txt line #4377 Emoji version 13.0
is Uni.new(0x1F1F7, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1F7, 0x1F1EA⟆ 🇷🇪 E2.0 flag: Réunion";
## 1F1F7 1F1F4                                ; fully-qualified     # 🇷🇴 E2.0 flag: Romania # emoji-test.txt line #4378 Emoji version 13.0
is Uni.new(0x1F1F7, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1F7, 0x1F1F4⟆ 🇷🇴 E2.0 flag: Romania";
## 1F1F7 1F1F8                                ; fully-qualified     # 🇷🇸 E2.0 flag: Serbia # emoji-test.txt line #4379 Emoji version 13.0
is Uni.new(0x1F1F7, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1F7, 0x1F1F8⟆ 🇷🇸 E2.0 flag: Serbia";
## 1F1F7 1F1FA                                ; fully-qualified     # 🇷🇺 E0.6 flag: Russia # emoji-test.txt line #4380 Emoji version 13.0
is Uni.new(0x1F1F7, 0x1F1FA).Str.chars, 1, "Codes: ⟅0x1F1F7, 0x1F1FA⟆ 🇷🇺 E0.6 flag: Russia";
## 1F1F7 1F1FC                                ; fully-qualified     # 🇷🇼 E2.0 flag: Rwanda # emoji-test.txt line #4381 Emoji version 13.0
is Uni.new(0x1F1F7, 0x1F1FC).Str.chars, 1, "Codes: ⟅0x1F1F7, 0x1F1FC⟆ 🇷🇼 E2.0 flag: Rwanda";
## 1F1F8 1F1E6                                ; fully-qualified     # 🇸🇦 E2.0 flag: Saudi Arabia # emoji-test.txt line #4382 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1E6⟆ 🇸🇦 E2.0 flag: Saudi Arabia";
## 1F1F8 1F1E7                                ; fully-qualified     # 🇸🇧 E2.0 flag: Solomon Islands # emoji-test.txt line #4383 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1E7).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1E7⟆ 🇸🇧 E2.0 flag: Solomon Islands";
## 1F1F8 1F1E8                                ; fully-qualified     # 🇸🇨 E2.0 flag: Seychelles # emoji-test.txt line #4384 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1E8).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1E8⟆ 🇸🇨 E2.0 flag: Seychelles";
## 1F1F8 1F1E9                                ; fully-qualified     # 🇸🇩 E2.0 flag: Sudan # emoji-test.txt line #4385 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1E9).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1E9⟆ 🇸🇩 E2.0 flag: Sudan";
## 1F1F8 1F1EA                                ; fully-qualified     # 🇸🇪 E2.0 flag: Sweden # emoji-test.txt line #4386 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1EA⟆ 🇸🇪 E2.0 flag: Sweden";
## 1F1F8 1F1EC                                ; fully-qualified     # 🇸🇬 E2.0 flag: Singapore # emoji-test.txt line #4387 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1EC⟆ 🇸🇬 E2.0 flag: Singapore";
## 1F1F8 1F1ED                                ; fully-qualified     # 🇸🇭 E2.0 flag: St. Helena # emoji-test.txt line #4388 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1ED).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1ED⟆ 🇸🇭 E2.0 flag: St. Helena";
## 1F1F8 1F1EE                                ; fully-qualified     # 🇸🇮 E2.0 flag: Slovenia # emoji-test.txt line #4389 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1EE).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1EE⟆ 🇸🇮 E2.0 flag: Slovenia";
## 1F1F8 1F1EF                                ; fully-qualified     # 🇸🇯 E2.0 flag: Svalbard & Jan Mayen # emoji-test.txt line #4390 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1EF).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1EF⟆ 🇸🇯 E2.0 flag: Svalbard & Jan Mayen";
## 1F1F8 1F1F0                                ; fully-qualified     # 🇸🇰 E2.0 flag: Slovakia # emoji-test.txt line #4391 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1F0).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1F0⟆ 🇸🇰 E2.0 flag: Slovakia";
## 1F1F8 1F1F1                                ; fully-qualified     # 🇸🇱 E2.0 flag: Sierra Leone # emoji-test.txt line #4392 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1F1).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1F1⟆ 🇸🇱 E2.0 flag: Sierra Leone";
## 1F1F8 1F1F2                                ; fully-qualified     # 🇸🇲 E2.0 flag: San Marino # emoji-test.txt line #4393 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1F2⟆ 🇸🇲 E2.0 flag: San Marino";
## 1F1F8 1F1F3                                ; fully-qualified     # 🇸🇳 E2.0 flag: Senegal # emoji-test.txt line #4394 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1F3⟆ 🇸🇳 E2.0 flag: Senegal";
## 1F1F8 1F1F4                                ; fully-qualified     # 🇸🇴 E2.0 flag: Somalia # emoji-test.txt line #4395 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1F4⟆ 🇸🇴 E2.0 flag: Somalia";
## 1F1F8 1F1F7                                ; fully-qualified     # 🇸🇷 E2.0 flag: Suriname # emoji-test.txt line #4396 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1F7⟆ 🇸🇷 E2.0 flag: Suriname";
## 1F1F8 1F1F8                                ; fully-qualified     # 🇸🇸 E2.0 flag: South Sudan # emoji-test.txt line #4397 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1F8⟆ 🇸🇸 E2.0 flag: South Sudan";
## 1F1F8 1F1F9                                ; fully-qualified     # 🇸🇹 E2.0 flag: São Tomé & Príncipe # emoji-test.txt line #4398 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1F9⟆ 🇸🇹 E2.0 flag: São Tomé & Príncipe";
## 1F1F8 1F1FB                                ; fully-qualified     # 🇸🇻 E2.0 flag: El Salvador # emoji-test.txt line #4399 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1FB).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1FB⟆ 🇸🇻 E2.0 flag: El Salvador";
## 1F1F8 1F1FD                                ; fully-qualified     # 🇸🇽 E2.0 flag: Sint Maarten # emoji-test.txt line #4400 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1FD).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1FD⟆ 🇸🇽 E2.0 flag: Sint Maarten";
## 1F1F8 1F1FE                                ; fully-qualified     # 🇸🇾 E2.0 flag: Syria # emoji-test.txt line #4401 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1FE).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1FE⟆ 🇸🇾 E2.0 flag: Syria";
## 1F1F8 1F1FF                                ; fully-qualified     # 🇸🇿 E2.0 flag: Eswatini # emoji-test.txt line #4402 Emoji version 13.0
is Uni.new(0x1F1F8, 0x1F1FF).Str.chars, 1, "Codes: ⟅0x1F1F8, 0x1F1FF⟆ 🇸🇿 E2.0 flag: Eswatini";
## 1F1F9 1F1E6                                ; fully-qualified     # 🇹🇦 E2.0 flag: Tristan da Cunha # emoji-test.txt line #4403 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1E6⟆ 🇹🇦 E2.0 flag: Tristan da Cunha";
## 1F1F9 1F1E8                                ; fully-qualified     # 🇹🇨 E2.0 flag: Turks & Caicos Islands # emoji-test.txt line #4404 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1E8).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1E8⟆ 🇹🇨 E2.0 flag: Turks & Caicos Islands";
## 1F1F9 1F1E9                                ; fully-qualified     # 🇹🇩 E2.0 flag: Chad # emoji-test.txt line #4405 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1E9).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1E9⟆ 🇹🇩 E2.0 flag: Chad";
## 1F1F9 1F1EB                                ; fully-qualified     # 🇹🇫 E2.0 flag: French Southern Territories # emoji-test.txt line #4406 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1EB).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1EB⟆ 🇹🇫 E2.0 flag: French Southern Territories";
## 1F1F9 1F1EC                                ; fully-qualified     # 🇹🇬 E2.0 flag: Togo # emoji-test.txt line #4407 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1EC⟆ 🇹🇬 E2.0 flag: Togo";
## 1F1F9 1F1ED                                ; fully-qualified     # 🇹🇭 E2.0 flag: Thailand # emoji-test.txt line #4408 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1ED).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1ED⟆ 🇹🇭 E2.0 flag: Thailand";
## 1F1F9 1F1EF                                ; fully-qualified     # 🇹🇯 E2.0 flag: Tajikistan # emoji-test.txt line #4409 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1EF).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1EF⟆ 🇹🇯 E2.0 flag: Tajikistan";
## 1F1F9 1F1F0                                ; fully-qualified     # 🇹🇰 E2.0 flag: Tokelau # emoji-test.txt line #4410 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1F0).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1F0⟆ 🇹🇰 E2.0 flag: Tokelau";
## 1F1F9 1F1F1                                ; fully-qualified     # 🇹🇱 E2.0 flag: Timor-Leste # emoji-test.txt line #4411 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1F1).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1F1⟆ 🇹🇱 E2.0 flag: Timor-Leste";
## 1F1F9 1F1F2                                ; fully-qualified     # 🇹🇲 E2.0 flag: Turkmenistan # emoji-test.txt line #4412 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1F2⟆ 🇹🇲 E2.0 flag: Turkmenistan";
## 1F1F9 1F1F3                                ; fully-qualified     # 🇹🇳 E2.0 flag: Tunisia # emoji-test.txt line #4413 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1F3⟆ 🇹🇳 E2.0 flag: Tunisia";
## 1F1F9 1F1F4                                ; fully-qualified     # 🇹🇴 E2.0 flag: Tonga # emoji-test.txt line #4414 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1F4).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1F4⟆ 🇹🇴 E2.0 flag: Tonga";
## 1F1F9 1F1F7                                ; fully-qualified     # 🇹🇷 E2.0 flag: Turkey # emoji-test.txt line #4415 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1F7).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1F7⟆ 🇹🇷 E2.0 flag: Turkey";
## 1F1F9 1F1F9                                ; fully-qualified     # 🇹🇹 E2.0 flag: Trinidad & Tobago # emoji-test.txt line #4416 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1F9⟆ 🇹🇹 E2.0 flag: Trinidad & Tobago";
## 1F1F9 1F1FB                                ; fully-qualified     # 🇹🇻 E2.0 flag: Tuvalu # emoji-test.txt line #4417 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1FB).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1FB⟆ 🇹🇻 E2.0 flag: Tuvalu";
## 1F1F9 1F1FC                                ; fully-qualified     # 🇹🇼 E2.0 flag: Taiwan # emoji-test.txt line #4418 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1FC).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1FC⟆ 🇹🇼 E2.0 flag: Taiwan";
## 1F1F9 1F1FF                                ; fully-qualified     # 🇹🇿 E2.0 flag: Tanzania # emoji-test.txt line #4419 Emoji version 13.0
is Uni.new(0x1F1F9, 0x1F1FF).Str.chars, 1, "Codes: ⟅0x1F1F9, 0x1F1FF⟆ 🇹🇿 E2.0 flag: Tanzania";
## 1F1FA 1F1E6                                ; fully-qualified     # 🇺🇦 E2.0 flag: Ukraine # emoji-test.txt line #4420 Emoji version 13.0
is Uni.new(0x1F1FA, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1FA, 0x1F1E6⟆ 🇺🇦 E2.0 flag: Ukraine";
## 1F1FA 1F1EC                                ; fully-qualified     # 🇺🇬 E2.0 flag: Uganda # emoji-test.txt line #4421 Emoji version 13.0
is Uni.new(0x1F1FA, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1FA, 0x1F1EC⟆ 🇺🇬 E2.0 flag: Uganda";
## 1F1FA 1F1F2                                ; fully-qualified     # 🇺🇲 E2.0 flag: U.S. Outlying Islands # emoji-test.txt line #4422 Emoji version 13.0
is Uni.new(0x1F1FA, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1FA, 0x1F1F2⟆ 🇺🇲 E2.0 flag: U.S. Outlying Islands";
## 1F1FA 1F1F3                                ; fully-qualified     # 🇺🇳 E4.0 flag: United Nations # emoji-test.txt line #4423 Emoji version 13.0
is Uni.new(0x1F1FA, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1FA, 0x1F1F3⟆ 🇺🇳 E4.0 flag: United Nations";
## 1F1FA 1F1F8                                ; fully-qualified     # 🇺🇸 E0.6 flag: United States # emoji-test.txt line #4424 Emoji version 13.0
is Uni.new(0x1F1FA, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1FA, 0x1F1F8⟆ 🇺🇸 E0.6 flag: United States";
## 1F1FA 1F1FE                                ; fully-qualified     # 🇺🇾 E2.0 flag: Uruguay # emoji-test.txt line #4425 Emoji version 13.0
is Uni.new(0x1F1FA, 0x1F1FE).Str.chars, 1, "Codes: ⟅0x1F1FA, 0x1F1FE⟆ 🇺🇾 E2.0 flag: Uruguay";
## 1F1FA 1F1FF                                ; fully-qualified     # 🇺🇿 E2.0 flag: Uzbekistan # emoji-test.txt line #4426 Emoji version 13.0
is Uni.new(0x1F1FA, 0x1F1FF).Str.chars, 1, "Codes: ⟅0x1F1FA, 0x1F1FF⟆ 🇺🇿 E2.0 flag: Uzbekistan";
## 1F1FB 1F1E6                                ; fully-qualified     # 🇻🇦 E2.0 flag: Vatican City # emoji-test.txt line #4427 Emoji version 13.0
is Uni.new(0x1F1FB, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1FB, 0x1F1E6⟆ 🇻🇦 E2.0 flag: Vatican City";
## 1F1FB 1F1E8                                ; fully-qualified     # 🇻🇨 E2.0 flag: St. Vincent & Grenadines # emoji-test.txt line #4428 Emoji version 13.0
is Uni.new(0x1F1FB, 0x1F1E8).Str.chars, 1, "Codes: ⟅0x1F1FB, 0x1F1E8⟆ 🇻🇨 E2.0 flag: St. Vincent & Grenadines";
## 1F1FB 1F1EA                                ; fully-qualified     # 🇻🇪 E2.0 flag: Venezuela # emoji-test.txt line #4429 Emoji version 13.0
is Uni.new(0x1F1FB, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1FB, 0x1F1EA⟆ 🇻🇪 E2.0 flag: Venezuela";
## 1F1FB 1F1EC                                ; fully-qualified     # 🇻🇬 E2.0 flag: British Virgin Islands # emoji-test.txt line #4430 Emoji version 13.0
is Uni.new(0x1F1FB, 0x1F1EC).Str.chars, 1, "Codes: ⟅0x1F1FB, 0x1F1EC⟆ 🇻🇬 E2.0 flag: British Virgin Islands";
## 1F1FB 1F1EE                                ; fully-qualified     # 🇻🇮 E2.0 flag: U.S. Virgin Islands # emoji-test.txt line #4431 Emoji version 13.0
is Uni.new(0x1F1FB, 0x1F1EE).Str.chars, 1, "Codes: ⟅0x1F1FB, 0x1F1EE⟆ 🇻🇮 E2.0 flag: U.S. Virgin Islands";
## 1F1FB 1F1F3                                ; fully-qualified     # 🇻🇳 E2.0 flag: Vietnam # emoji-test.txt line #4432 Emoji version 13.0
is Uni.new(0x1F1FB, 0x1F1F3).Str.chars, 1, "Codes: ⟅0x1F1FB, 0x1F1F3⟆ 🇻🇳 E2.0 flag: Vietnam";
## 1F1FB 1F1FA                                ; fully-qualified     # 🇻🇺 E2.0 flag: Vanuatu # emoji-test.txt line #4433 Emoji version 13.0
is Uni.new(0x1F1FB, 0x1F1FA).Str.chars, 1, "Codes: ⟅0x1F1FB, 0x1F1FA⟆ 🇻🇺 E2.0 flag: Vanuatu";
## 1F1FC 1F1EB                                ; fully-qualified     # 🇼🇫 E2.0 flag: Wallis & Futuna # emoji-test.txt line #4434 Emoji version 13.0
is Uni.new(0x1F1FC, 0x1F1EB).Str.chars, 1, "Codes: ⟅0x1F1FC, 0x1F1EB⟆ 🇼🇫 E2.0 flag: Wallis & Futuna";
## 1F1FC 1F1F8                                ; fully-qualified     # 🇼🇸 E2.0 flag: Samoa # emoji-test.txt line #4435 Emoji version 13.0
is Uni.new(0x1F1FC, 0x1F1F8).Str.chars, 1, "Codes: ⟅0x1F1FC, 0x1F1F8⟆ 🇼🇸 E2.0 flag: Samoa";
## 1F1FD 1F1F0                                ; fully-qualified     # 🇽🇰 E2.0 flag: Kosovo # emoji-test.txt line #4436 Emoji version 13.0
is Uni.new(0x1F1FD, 0x1F1F0).Str.chars, 1, "Codes: ⟅0x1F1FD, 0x1F1F0⟆ 🇽🇰 E2.0 flag: Kosovo";
## 1F1FE 1F1EA                                ; fully-qualified     # 🇾🇪 E2.0 flag: Yemen # emoji-test.txt line #4437 Emoji version 13.0
is Uni.new(0x1F1FE, 0x1F1EA).Str.chars, 1, "Codes: ⟅0x1F1FE, 0x1F1EA⟆ 🇾🇪 E2.0 flag: Yemen";
## 1F1FE 1F1F9                                ; fully-qualified     # 🇾🇹 E2.0 flag: Mayotte # emoji-test.txt line #4438 Emoji version 13.0
is Uni.new(0x1F1FE, 0x1F1F9).Str.chars, 1, "Codes: ⟅0x1F1FE, 0x1F1F9⟆ 🇾🇹 E2.0 flag: Mayotte";
## 1F1FF 1F1E6                                ; fully-qualified     # 🇿🇦 E2.0 flag: South Africa # emoji-test.txt line #4439 Emoji version 13.0
is Uni.new(0x1F1FF, 0x1F1E6).Str.chars, 1, "Codes: ⟅0x1F1FF, 0x1F1E6⟆ 🇿🇦 E2.0 flag: South Africa";
## 1F1FF 1F1F2                                ; fully-qualified     # 🇿🇲 E2.0 flag: Zambia # emoji-test.txt line #4440 Emoji version 13.0
is Uni.new(0x1F1FF, 0x1F1F2).Str.chars, 1, "Codes: ⟅0x1F1FF, 0x1F1F2⟆ 🇿🇲 E2.0 flag: Zambia";
## 1F1FF 1F1FC                                ; fully-qualified     # 🇿🇼 E2.0 flag: Zimbabwe # emoji-test.txt line #4441 Emoji version 13.0
is Uni.new(0x1F1FF, 0x1F1FC).Str.chars, 1, "Codes: ⟅0x1F1FF, 0x1F1FC⟆ 🇿🇼 E2.0 flag: Zimbabwe";
## 1F3F4 E0067 E0062 E0065 E006E E0067 E007F  ; fully-qualified     # 🏴󠁧󠁢󠁥󠁮󠁧󠁿 E5.0 flag: England # emoji-test.txt line #4444 Emoji version 13.0
is Uni.new(0x1F3F4, 0xE0067, 0xE0062, 0xE0065, 0xE006E, 0xE0067, 0xE007F).Str.chars, 1, "Codes: ⟅0x1F3F4, 0xE0067, 0xE0062, 0xE0065, 0xE006E, 0xE0067, 0xE007F⟆ 🏴󠁧󠁢󠁥󠁮󠁧󠁿 E5.0 flag: England";
## 1F3F4 E0067 E0062 E0073 E0063 E0074 E007F  ; fully-qualified     # 🏴󠁧󠁢󠁳󠁣󠁴󠁿 E5.0 flag: Scotland # emoji-test.txt line #4445 Emoji version 13.0
is Uni.new(0x1F3F4, 0xE0067, 0xE0062, 0xE0073, 0xE0063, 0xE0074, 0xE007F).Str.chars, 1, "Codes: ⟅0x1F3F4, 0xE0067, 0xE0062, 0xE0073, 0xE0063, 0xE0074, 0xE007F⟆ 🏴󠁧󠁢󠁳󠁣󠁴󠁿 E5.0 flag: Scotland";
## 1F3F4 E0067 E0062 E0077 E006C E0073 E007F  ; fully-qualified     # 🏴󠁧󠁢󠁷󠁬󠁳󠁿 E5.0 flag: Wales # emoji-test.txt line #4446 Emoji version 13.0
is Uni.new(0x1F3F4, 0xE0067, 0xE0062, 0xE0077, 0xE006C, 0xE0073, 0xE007F).Str.chars, 1, "Codes: ⟅0x1F3F4, 0xE0067, 0xE0062, 0xE0077, 0xE006C, 0xE0073, 0xE007F⟆ 🏴󠁧󠁢󠁷󠁬󠁳󠁿 E5.0 flag: Wales";

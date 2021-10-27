enum keysym is export (

XK_VoidSymbol => 0xffffff, #=  Void symbol

#ifdef XK_MISCELLANY
#
# TTY function keys, cleverly chosen to map to ASCII, for convenience of
# programming, but could have been arbitrary (at the cost of lookup
# tables in client code).
#

XK_BackSpace => 0xff08, #=  Back space, back char
XK_Tab => 0xff09,
XK_Linefeed => 0xff0a, #=  Linefeed, LF
XK_Clear => 0xff0b,
XK_Return => 0xff0d, #=  Return, enter
XK_Pause => 0xff13, #=  Pause, hold
XK_Scroll_Lock => 0xff14,
XK_Sys_Req => 0xff15,
XK_Escape => 0xff1b,
XK_Delete => 0xffff, #=  Delete, rubout



# International & multi-key character composition

XK_Multi_key => 0xff20, #=  Multi-key character compose
XK_Codeinput => 0xff37,
XK_SingleCandidate => 0xff3c,
XK_MultipleCandidate => 0xff3d,
XK_PreviousCandidate => 0xff3e,
# Japanese keyboard support

XK_Kanji => 0xff21, #=  Kanji, Kanji convert
XK_Muhenkan => 0xff22, #=  Cancel Conversion
XK_Henkan_Mode => 0xff23, #=  Start/Stop Conversion
XK_Henkan => 0xff23, #=  Alias for Henkan_Mode
XK_Romaji => 0xff24, #=  to Romaji
XK_Hiragana => 0xff25, #=  to Hiragana
XK_Katakana => 0xff26, #=  to Katakana
XK_Hiragana_Katakana => 0xff27, #=  Hiragana/Katakana toggle
XK_Zenkaku => 0xff28, #=  to Zenkaku
XK_Hankaku => 0xff29, #=  to Hankaku
XK_Zenkaku_Hankaku => 0xff2a, #=  Zenkaku/Hankaku toggle
XK_Touroku => 0xff2b, #=  Add to Dictionary
XK_Massyo => 0xff2c, #=  Delete from Dictionary
XK_Kana_Lock => 0xff2d, #=  Kana Lock
XK_Kana_Shift => 0xff2e, #=  Kana Shift
XK_Eisu_Shift => 0xff2f, #=  Alphanumeric Shift
XK_Eisu_toggle => 0xff30, #=  Alphanumeric toggle
XK_Kanji_Bangou => 0xff37, #=  Codeinput
XK_Zen_Koho => 0xff3d, #=  Multiple/All Candidate(s)
XK_Mae_Koho => 0xff3e, #=  Previous Candidate

# 0xff31 thru 0xff3f are under XK_KOREAN

# Cursor control & motion

XK_Home => 0xff50,
XK_Left => 0xff51, #=  Move left, left arrow
XK_Up => 0xff52, #=  Move up, up arrow
XK_Right => 0xff53, #=  Move right, right arrow
XK_Down => 0xff54, #=  Move down, down arrow
XK_Prior => 0xff55, #=  Prior, previous
XK_Page_Up => 0xff55,
XK_Next => 0xff56, #=  Next
XK_Page_Down => 0xff56,
XK_End => 0xff57, #=  EOL
XK_Begin => 0xff58, #=  BOL


# Misc functions

XK_Select => 0xff60, #=  Select, mark
XK_Print => 0xff61,
XK_Execute => 0xff62, #=  Execute, run, do
XK_Insert => 0xff63, #=  Insert, insert here
XK_Undo => 0xff65,
XK_Redo => 0xff66, #=  Redo, again
XK_Menu => 0xff67,
XK_Find => 0xff68, #=  Find, search
XK_Cancel => 0xff69, #=  Cancel, stop, abort, exit
XK_Help => 0xff6a, #=  Help
XK_Break => 0xff6b,
XK_Mode_switch => 0xff7e, #=  Character set switch
XK_script_switch => 0xff7e, #=  Alias for mode_switch
XK_Num_Lock => 0xff7f,
# Keypad functions, keypad numbers cleverly chosen to map to ASCII

XK_KP_Space => 0xff80, #=  Space
XK_KP_Tab => 0xff89,
XK_KP_Enter => 0xff8d, #=  Enter
XK_KP_F1 => 0xff91, #=  PF1, KP_A, ...
XK_KP_F2 => 0xff92,
XK_KP_F3 => 0xff93,
XK_KP_F4 => 0xff94,
XK_KP_Home => 0xff95,
XK_KP_Left => 0xff96,
XK_KP_Up => 0xff97,
XK_KP_Right => 0xff98,
XK_KP_Down => 0xff99,
XK_KP_Prior => 0xff9a,
XK_KP_Page_Up => 0xff9a,
XK_KP_Next => 0xff9b,
XK_KP_Page_Down => 0xff9b,
XK_KP_End => 0xff9c,
XK_KP_Begin => 0xff9d,
XK_KP_Insert => 0xff9e,
XK_KP_Delete => 0xff9f,
XK_KP_Equal => 0xffbd, #=  Equals
XK_KP_Multiply => 0xffaa,
XK_KP_Add => 0xffab,
XK_KP_Separator => 0xffac, #=  Separator, often comma
XK_KP_Subtract => 0xffad,
XK_KP_Decimal => 0xffae,
XK_KP_Divide => 0xffaf,
XK_KP_0 => 0xffb0,
XK_KP_1 => 0xffb1,
XK_KP_2 => 0xffb2,
XK_KP_3 => 0xffb3,
XK_KP_4 => 0xffb4,
XK_KP_5 => 0xffb5,
XK_KP_6 => 0xffb6,
XK_KP_7 => 0xffb7,
XK_KP_8 => 0xffb8,
XK_KP_9 => 0xffb9,
#
# Auxiliary functions; note the duplicate definitions for left and right
# function keys;  Sun keyboards and a few other manufacturers have such
# function key groups on the left and/or right sides of the keyboard.
# We've not found a keyboard with more than 35 function keys total.
#

XK_F1 => 0xffbe,
XK_F2 => 0xffbf,
XK_F3 => 0xffc0,
XK_F4 => 0xffc1,
XK_F5 => 0xffc2,
XK_F6 => 0xffc3,
XK_F7 => 0xffc4,
XK_F8 => 0xffc5,
XK_F9 => 0xffc6,
XK_F10 => 0xffc7,
XK_F11 => 0xffc8,
XK_L1 => 0xffc8,
XK_F12 => 0xffc9,
XK_L2 => 0xffc9,
XK_F13 => 0xffca,
XK_L3 => 0xffca,
XK_F14 => 0xffcb,
XK_L4 => 0xffcb,
XK_F15 => 0xffcc,
XK_L5 => 0xffcc,
XK_F16 => 0xffcd,
XK_L6 => 0xffcd,
XK_F17 => 0xffce,
XK_L7 => 0xffce,
XK_F18 => 0xffcf,
XK_L8 => 0xffcf,
XK_F19 => 0xffd0,
XK_L9 => 0xffd0,
XK_F20 => 0xffd1,
XK_L10 => 0xffd1,
XK_F21 => 0xffd2,
XK_R1 => 0xffd2,
XK_F22 => 0xffd3,
XK_R2 => 0xffd3,
XK_F23 => 0xffd4,
XK_R3 => 0xffd4,
XK_F24 => 0xffd5,
XK_R4 => 0xffd5,
XK_F25 => 0xffd6,
XK_R5 => 0xffd6,
XK_F26 => 0xffd7,
XK_R6 => 0xffd7,
XK_F27 => 0xffd8,
XK_R7 => 0xffd8,
XK_F28 => 0xffd9,
XK_R8 => 0xffd9,
XK_F29 => 0xffda,
XK_R9 => 0xffda,
XK_F30 => 0xffdb,
XK_R10 => 0xffdb,
XK_F31 => 0xffdc,
XK_R11 => 0xffdc,
XK_F32 => 0xffdd,
XK_R12 => 0xffdd,
XK_F33 => 0xffde,
XK_R13 => 0xffde,
XK_F34 => 0xffdf,
XK_R14 => 0xffdf,
XK_F35 => 0xffe0,
XK_R15 => 0xffe0,
# Modifiers

XK_Shift_L => 0xffe1, #=  Left shift
XK_Shift_R => 0xffe2, #=  Right shift
XK_Control_L => 0xffe3, #=  Left control
XK_Control_R => 0xffe4, #=  Right control
XK_Caps_Lock => 0xffe5, #=  Caps lock
XK_Shift_Lock => 0xffe6, #=  Shift lock

XK_Meta_L => 0xffe7, #=  Left meta
XK_Meta_R => 0xffe8, #=  Right meta
XK_Alt_L => 0xffe9, #=  Left alt
XK_Alt_R => 0xffea, #=  Right alt
XK_Super_L => 0xffeb, #=  Left super
XK_Super_R => 0xffec, #=  Right super
XK_Hyper_L => 0xffed, #=  Left hyper
XK_Hyper_R => 0xffee, #=  Right hyper
#endif /* XK_MISCELLANY

#
# Keyboard (XKB) Extension function and modifier keys
# (from Appendix C of "The X Keyboard Extension: Protocol Specification")
# Byte 3 = 0xfe
#

#ifdef XK_XKB_KEYS
XK_ISO_Lock => 0xfe01,
XK_ISO_Level2_Latch => 0xfe02,
XK_ISO_Level3_Shift => 0xfe03,
XK_ISO_Level3_Latch => 0xfe04,
XK_ISO_Level3_Lock => 0xfe05,
XK_ISO_Level5_Shift => 0xfe11,
XK_ISO_Level5_Latch => 0xfe12,
XK_ISO_Level5_Lock => 0xfe13,
XK_ISO_Group_Shift => 0xff7e, #=  Alias for mode_switch
XK_ISO_Group_Latch => 0xfe06,
XK_ISO_Group_Lock => 0xfe07,
XK_ISO_Next_Group => 0xfe08,
XK_ISO_Next_Group_Lock => 0xfe09,
XK_ISO_Prev_Group => 0xfe0a,
XK_ISO_Prev_Group_Lock => 0xfe0b,
XK_ISO_First_Group => 0xfe0c,
XK_ISO_First_Group_Lock => 0xfe0d,
XK_ISO_Last_Group => 0xfe0e,
XK_ISO_Last_Group_Lock => 0xfe0f,
XK_ISO_Left_Tab => 0xfe20,
XK_ISO_Move_Line_Up => 0xfe21,
XK_ISO_Move_Line_Down => 0xfe22,
XK_ISO_Partial_Line_Up => 0xfe23,
XK_ISO_Partial_Line_Down => 0xfe24,
XK_ISO_Partial_Space_Left => 0xfe25,
XK_ISO_Partial_Space_Right => 0xfe26,
XK_ISO_Set_Margin_Left => 0xfe27,
XK_ISO_Set_Margin_Right => 0xfe28,
XK_ISO_Release_Margin_Left => 0xfe29,
XK_ISO_Release_Margin_Right => 0xfe2a,
XK_ISO_Release_Both_Margins => 0xfe2b,
XK_ISO_Fast_Cursor_Left => 0xfe2c,
XK_ISO_Fast_Cursor_Right => 0xfe2d,
XK_ISO_Fast_Cursor_Up => 0xfe2e,
XK_ISO_Fast_Cursor_Down => 0xfe2f,
XK_ISO_Continuous_Underline => 0xfe30,
XK_ISO_Discontinuous_Underline => 0xfe31,
XK_ISO_Emphasize => 0xfe32,
XK_ISO_Center_Object => 0xfe33,
XK_ISO_Enter => 0xfe34,
XK_dead_grave => 0xfe50,
XK_dead_acute => 0xfe51,
XK_dead_circumflex => 0xfe52,
XK_dead_tilde => 0xfe53,
XK_dead_perispomeni => 0xfe53, #=  alias for dead_tilde
XK_dead_macron => 0xfe54,
XK_dead_breve => 0xfe55,
XK_dead_abovedot => 0xfe56,
XK_dead_diaeresis => 0xfe57,
XK_dead_abovering => 0xfe58,
XK_dead_doubleacute => 0xfe59,
XK_dead_caron => 0xfe5a,
XK_dead_cedilla => 0xfe5b,
XK_dead_ogonek => 0xfe5c,
XK_dead_iota => 0xfe5d,
XK_dead_voiced_sound => 0xfe5e,
XK_dead_semivoiced_sound => 0xfe5f,
XK_dead_belowdot => 0xfe60,
XK_dead_hook => 0xfe61,
XK_dead_horn => 0xfe62,
XK_dead_stroke => 0xfe63,
XK_dead_abovecomma => 0xfe64,
XK_dead_psili => 0xfe64, #=  alias for dead_abovecomma
XK_dead_abovereversedcomma => 0xfe65,
XK_dead_dasia => 0xfe65, #=  alias for dead_abovereversedcomma
XK_dead_doublegrave => 0xfe66,
XK_dead_belowring => 0xfe67,
XK_dead_belowmacron => 0xfe68,
XK_dead_belowcircumflex => 0xfe69,
XK_dead_belowtilde => 0xfe6a,
XK_dead_belowbreve => 0xfe6b,
XK_dead_belowdiaeresis => 0xfe6c,
XK_dead_invertedbreve => 0xfe6d,
XK_dead_belowcomma => 0xfe6e,
XK_dead_currency => 0xfe6f,
# extra dead elements for German T3 layout
XK_dead_lowline => 0xfe90,
XK_dead_aboveverticalline => 0xfe91,
XK_dead_belowverticalline => 0xfe92,
XK_dead_longsolidusoverlay => 0xfe93,
# dead vowels for universal syllable entry
XK_dead_a => 0xfe80,
XK_dead_A => 0xfe81,
XK_dead_e => 0xfe82,
XK_dead_E => 0xfe83,
XK_dead_i => 0xfe84,
XK_dead_I => 0xfe85,
XK_dead_o => 0xfe86,
XK_dead_O => 0xfe87,
XK_dead_u => 0xfe88,
XK_dead_U => 0xfe89,
XK_dead_small_schwa => 0xfe8a,
XK_dead_capital_schwa => 0xfe8b,
XK_dead_greek => 0xfe8c,
XK_First_Virtual_Screen => 0xfed0,
XK_Prev_Virtual_Screen => 0xfed1,
XK_Next_Virtual_Screen => 0xfed2,
XK_Last_Virtual_Screen => 0xfed4,
XK_Terminate_Server => 0xfed5,
XK_AccessX_Enable => 0xfe70,
XK_AccessX_Feedback_Enable => 0xfe71,
XK_RepeatKeys_Enable => 0xfe72,
XK_SlowKeys_Enable => 0xfe73,
XK_BounceKeys_Enable => 0xfe74,
XK_StickyKeys_Enable => 0xfe75,
XK_MouseKeys_Enable => 0xfe76,
XK_MouseKeys_Accel_Enable => 0xfe77,
XK_Overlay1_Enable => 0xfe78,
XK_Overlay2_Enable => 0xfe79,
XK_AudibleBell_Enable => 0xfe7a,
XK_Pointer_Left => 0xfee0,
XK_Pointer_Right => 0xfee1,
XK_Pointer_Up => 0xfee2,
XK_Pointer_Down => 0xfee3,
XK_Pointer_UpLeft => 0xfee4,
XK_Pointer_UpRight => 0xfee5,
XK_Pointer_DownLeft => 0xfee6,
XK_Pointer_DownRight => 0xfee7,
XK_Pointer_Button_Dflt => 0xfee8,
XK_Pointer_Button1 => 0xfee9,
XK_Pointer_Button2 => 0xfeea,
XK_Pointer_Button3 => 0xfeeb,
XK_Pointer_Button4 => 0xfeec,
XK_Pointer_Button5 => 0xfeed,
XK_Pointer_DblClick_Dflt => 0xfeee,
XK_Pointer_DblClick1 => 0xfeef,
XK_Pointer_DblClick2 => 0xfef0,
XK_Pointer_DblClick3 => 0xfef1,
XK_Pointer_DblClick4 => 0xfef2,
XK_Pointer_DblClick5 => 0xfef3,
XK_Pointer_Drag_Dflt => 0xfef4,
XK_Pointer_Drag1 => 0xfef5,
XK_Pointer_Drag2 => 0xfef6,
XK_Pointer_Drag3 => 0xfef7,
XK_Pointer_Drag4 => 0xfef8,
XK_Pointer_Drag5 => 0xfefd,
XK_Pointer_EnableKeys => 0xfef9,
XK_Pointer_Accelerate => 0xfefa,
XK_Pointer_DfltBtnNext => 0xfefb,
XK_Pointer_DfltBtnPrev => 0xfefc,
# Single-Stroke Multiple-Character N-Graph Keysyms For The X Input Method

XK_ch => 0xfea0,
XK_Ch => 0xfea1,
XK_CH => 0xfea2,
XK_c_h => 0xfea3,
XK_C_h => 0xfea4,
XK_C_H => 0xfea5,
#endif /* XK_XKB_KEYS

#
# 3270 Terminal Keys
# Byte 3 = 0xfd
#

#ifdef XK_3270
XK_3270_Duplicate => 0xfd01,
XK_3270_FieldMark => 0xfd02,
XK_3270_Right2 => 0xfd03,
XK_3270_Left2 => 0xfd04,
XK_3270_BackTab => 0xfd05,
XK_3270_EraseEOF => 0xfd06,
XK_3270_EraseInput => 0xfd07,
XK_3270_Reset => 0xfd08,
XK_3270_Quit => 0xfd09,
XK_3270_PA1 => 0xfd0a,
XK_3270_PA2 => 0xfd0b,
XK_3270_PA3 => 0xfd0c,
XK_3270_Test => 0xfd0d,
XK_3270_Attn => 0xfd0e,
XK_3270_CursorBlink => 0xfd0f,
XK_3270_AltCursor => 0xfd10,
XK_3270_KeyClick => 0xfd11,
XK_3270_Jump => 0xfd12,
XK_3270_Ident => 0xfd13,
XK_3270_Rule => 0xfd14,
XK_3270_Copy => 0xfd15,
XK_3270_Play => 0xfd16,
XK_3270_Setup => 0xfd17,
XK_3270_Record => 0xfd18,
XK_3270_ChangeScreen => 0xfd19,
XK_3270_DeleteWord => 0xfd1a,
XK_3270_ExSelect => 0xfd1b,
XK_3270_CursorSelect => 0xfd1c,
XK_3270_PrintScreen => 0xfd1d,
XK_3270_Enter => 0xfd1e,
#endif /* XK_3270

#
# Latin 1
# (ISO/IEC 8859-1 = Unicode U+0020..U+00FF)
# Byte 3 = 0
#
#ifdef XK_LATIN1
XK_space => 0x0020, #=  U+0020 SPACE
XK_exclam => 0x0021, #=  U+0021 EXCLAMATION MARK
XK_quotedbl => 0x0022, #=  U+0022 QUOTATION MARK
XK_numbersign => 0x0023, #=  U+0023 NUMBER SIGN
XK_dollar => 0x0024, #=  U+0024 DOLLAR SIGN
XK_percent => 0x0025, #=  U+0025 PERCENT SIGN
XK_ampersand => 0x0026, #=  U+0026 AMPERSAND
XK_apostrophe => 0x0027, #=  U+0027 APOSTROPHE
XK_quoteright => 0x0027, #=  deprecated
XK_parenleft => 0x0028, #=  U+0028 LEFT PARENTHESIS
XK_parenright => 0x0029, #=  U+0029 RIGHT PARENTHESIS
XK_asterisk => 0x002a, #=  U+002A ASTERISK
XK_plus => 0x002b, #=  U+002B PLUS SIGN
XK_comma => 0x002c, #=  U+002C COMMA
XK_minus => 0x002d, #=  U+002D HYPHEN-MINUS
XK_period => 0x002e, #=  U+002E FULL STOP
XK_slash => 0x002f, #=  U+002F SOLIDUS
XK_0 => 0x0030, #=  U+0030 DIGIT ZERO
XK_1 => 0x0031, #=  U+0031 DIGIT ONE
XK_2 => 0x0032, #=  U+0032 DIGIT TWO
XK_3 => 0x0033, #=  U+0033 DIGIT THREE
XK_4 => 0x0034, #=  U+0034 DIGIT FOUR
XK_5 => 0x0035, #=  U+0035 DIGIT FIVE
XK_6 => 0x0036, #=  U+0036 DIGIT SIX
XK_7 => 0x0037, #=  U+0037 DIGIT SEVEN
XK_8 => 0x0038, #=  U+0038 DIGIT EIGHT
XK_9 => 0x0039, #=  U+0039 DIGIT NINE
XK_colon => 0x003a, #=  U+003A COLON
XK_semicolon => 0x003b, #=  U+003B SEMICOLON
XK_less => 0x003c, #=  U+003C LESS-THAN SIGN
XK_equal => 0x003d, #=  U+003D EQUALS SIGN
XK_greater => 0x003e, #=  U+003E GREATER-THAN SIGN
XK_question => 0x003f, #=  U+003F QUESTION MARK
XK_at => 0x0040, #=  U+0040 COMMERCIAL AT
XK_A => 0x0041, #=  U+0041 LATIN CAPITAL LETTER A
XK_B => 0x0042, #=  U+0042 LATIN CAPITAL LETTER B
XK_C => 0x0043, #=  U+0043 LATIN CAPITAL LETTER C
XK_D => 0x0044, #=  U+0044 LATIN CAPITAL LETTER D
XK_E => 0x0045, #=  U+0045 LATIN CAPITAL LETTER E
XK_F => 0x0046, #=  U+0046 LATIN CAPITAL LETTER F
XK_G => 0x0047, #=  U+0047 LATIN CAPITAL LETTER G
XK_H => 0x0048, #=  U+0048 LATIN CAPITAL LETTER H
XK_I => 0x0049, #=  U+0049 LATIN CAPITAL LETTER I
XK_J => 0x004a, #=  U+004A LATIN CAPITAL LETTER J
XK_K => 0x004b, #=  U+004B LATIN CAPITAL LETTER K
XK_L => 0x004c, #=  U+004C LATIN CAPITAL LETTER L
XK_M => 0x004d, #=  U+004D LATIN CAPITAL LETTER M
XK_N => 0x004e, #=  U+004E LATIN CAPITAL LETTER N
XK_O => 0x004f, #=  U+004F LATIN CAPITAL LETTER O
XK_P => 0x0050, #=  U+0050 LATIN CAPITAL LETTER P
XK_Q => 0x0051, #=  U+0051 LATIN CAPITAL LETTER Q
XK_R => 0x0052, #=  U+0052 LATIN CAPITAL LETTER R
XK_S => 0x0053, #=  U+0053 LATIN CAPITAL LETTER S
XK_T => 0x0054, #=  U+0054 LATIN CAPITAL LETTER T
XK_U => 0x0055, #=  U+0055 LATIN CAPITAL LETTER U
XK_V => 0x0056, #=  U+0056 LATIN CAPITAL LETTER V
XK_W => 0x0057, #=  U+0057 LATIN CAPITAL LETTER W
XK_X => 0x0058, #=  U+0058 LATIN CAPITAL LETTER X
XK_Y => 0x0059, #=  U+0059 LATIN CAPITAL LETTER Y
XK_Z => 0x005a, #=  U+005A LATIN CAPITAL LETTER Z
XK_bracketleft => 0x005b, #=  U+005B LEFT SQUARE BRACKET
XK_backslash => 0x005c, #=  U+005C REVERSE SOLIDUS
XK_bracketright => 0x005d, #=  U+005D RIGHT SQUARE BRACKET
XK_asciicircum => 0x005e, #=  U+005E CIRCUMFLEX ACCENT
XK_underscore => 0x005f, #=  U+005F LOW LINE
XK_grave => 0x0060, #=  U+0060 GRAVE ACCENT
XK_quoteleft => 0x0060, #=  deprecated
XK_a => 0x0061, #=  U+0061 LATIN SMALL LETTER A
XK_b => 0x0062, #=  U+0062 LATIN SMALL LETTER B
XK_c => 0x0063, #=  U+0063 LATIN SMALL LETTER C
XK_d => 0x0064, #=  U+0064 LATIN SMALL LETTER D
XK_e => 0x0065, #=  U+0065 LATIN SMALL LETTER E
XK_f => 0x0066, #=  U+0066 LATIN SMALL LETTER F
XK_g => 0x0067, #=  U+0067 LATIN SMALL LETTER G
XK_h => 0x0068, #=  U+0068 LATIN SMALL LETTER H
XK_i => 0x0069, #=  U+0069 LATIN SMALL LETTER I
XK_j => 0x006a, #=  U+006A LATIN SMALL LETTER J
XK_k => 0x006b, #=  U+006B LATIN SMALL LETTER K
XK_l => 0x006c, #=  U+006C LATIN SMALL LETTER L
XK_m => 0x006d, #=  U+006D LATIN SMALL LETTER M
XK_n => 0x006e, #=  U+006E LATIN SMALL LETTER N
XK_o => 0x006f, #=  U+006F LATIN SMALL LETTER O
XK_p => 0x0070, #=  U+0070 LATIN SMALL LETTER P
XK_q => 0x0071, #=  U+0071 LATIN SMALL LETTER Q
XK_r => 0x0072, #=  U+0072 LATIN SMALL LETTER R
XK_s => 0x0073, #=  U+0073 LATIN SMALL LETTER S
XK_t => 0x0074, #=  U+0074 LATIN SMALL LETTER T
XK_u => 0x0075, #=  U+0075 LATIN SMALL LETTER U
XK_v => 0x0076, #=  U+0076 LATIN SMALL LETTER V
XK_w => 0x0077, #=  U+0077 LATIN SMALL LETTER W
XK_x => 0x0078, #=  U+0078 LATIN SMALL LETTER X
XK_y => 0x0079, #=  U+0079 LATIN SMALL LETTER Y
XK_z => 0x007a, #=  U+007A LATIN SMALL LETTER Z
XK_braceleft => 0x007b, #=  U+007B LEFT CURLY BRACKET
XK_bar => 0x007c, #=  U+007C VERTICAL LINE
XK_braceright => 0x007d, #=  U+007D RIGHT CURLY BRACKET
XK_asciitilde => 0x007e, #=  U+007E TILDE

XK_nobreakspace => 0x00a0, #=  U+00A0 NO-BREAK SPACE
XK_exclamdown => 0x00a1, #=  U+00A1 INVERTED EXCLAMATION MARK
XK_cent => 0x00a2, #=  U+00A2 CENT SIGN
XK_sterling => 0x00a3, #=  U+00A3 POUND SIGN
XK_currency => 0x00a4, #=  U+00A4 CURRENCY SIGN
XK_yen => 0x00a5, #=  U+00A5 YEN SIGN
XK_brokenbar => 0x00a6, #=  U+00A6 BROKEN BAR
XK_section => 0x00a7, #=  U+00A7 SECTION SIGN
XK_diaeresis => 0x00a8, #=  U+00A8 DIAERESIS
XK_copyright => 0x00a9, #=  U+00A9 COPYRIGHT SIGN
XK_ordfeminine => 0x00aa, #=  U+00AA FEMININE ORDINAL INDICATOR
XK_guillemotleft => 0x00ab, #=  U+00AB LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
XK_notsign => 0x00ac, #=  U+00AC NOT SIGN
XK_hyphen => 0x00ad, #=  U+00AD SOFT HYPHEN
XK_registered => 0x00ae, #=  U+00AE REGISTERED SIGN
XK_macron => 0x00af, #=  U+00AF MACRON
XK_degree => 0x00b0, #=  U+00B0 DEGREE SIGN
XK_plusminus => 0x00b1, #=  U+00B1 PLUS-MINUS SIGN
XK_twosuperior => 0x00b2, #=  U+00B2 SUPERSCRIPT TWO
XK_threesuperior => 0x00b3, #=  U+00B3 SUPERSCRIPT THREE
XK_acute => 0x00b4, #=  U+00B4 ACUTE ACCENT
XK_mu => 0x00b5, #=  U+00B5 MICRO SIGN
XK_paragraph => 0x00b6, #=  U+00B6 PILCROW SIGN
XK_periodcentered => 0x00b7, #=  U+00B7 MIDDLE DOT
XK_cedilla => 0x00b8, #=  U+00B8 CEDILLA
XK_onesuperior => 0x00b9, #=  U+00B9 SUPERSCRIPT ONE
XK_masculine => 0x00ba, #=  U+00BA MASCULINE ORDINAL INDICATOR
XK_guillemotright => 0x00bb, #=  U+00BB RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
XK_onequarter => 0x00bc, #=  U+00BC VULGAR FRACTION ONE QUARTER
XK_onehalf => 0x00bd, #=  U+00BD VULGAR FRACTION ONE HALF
XK_threequarters => 0x00be, #=  U+00BE VULGAR FRACTION THREE QUARTERS
XK_questiondown => 0x00bf, #=  U+00BF INVERTED QUESTION MARK
XK_Agrave => 0x00c0, #=  U+00C0 LATIN CAPITAL LETTER A WITH GRAVE
XK_Aacute => 0x00c1, #=  U+00C1 LATIN CAPITAL LETTER A WITH ACUTE
XK_Acircumflex => 0x00c2, #=  U+00C2 LATIN CAPITAL LETTER A WITH CIRCUMFLEX
XK_Atilde => 0x00c3, #=  U+00C3 LATIN CAPITAL LETTER A WITH TILDE
XK_Adiaeresis => 0x00c4, #=  U+00C4 LATIN CAPITAL LETTER A WITH DIAERESIS
XK_Aring => 0x00c5, #=  U+00C5 LATIN CAPITAL LETTER A WITH RING ABOVE
XK_AE => 0x00c6, #=  U+00C6 LATIN CAPITAL LETTER AE
XK_Ccedilla => 0x00c7, #=  U+00C7 LATIN CAPITAL LETTER C WITH CEDILLA
XK_Egrave => 0x00c8, #=  U+00C8 LATIN CAPITAL LETTER E WITH GRAVE
XK_Eacute => 0x00c9, #=  U+00C9 LATIN CAPITAL LETTER E WITH ACUTE
XK_Ecircumflex => 0x00ca, #=  U+00CA LATIN CAPITAL LETTER E WITH CIRCUMFLEX
XK_Ediaeresis => 0x00cb, #=  U+00CB LATIN CAPITAL LETTER E WITH DIAERESIS
XK_Igrave => 0x00cc, #=  U+00CC LATIN CAPITAL LETTER I WITH GRAVE
XK_Iacute => 0x00cd, #=  U+00CD LATIN CAPITAL LETTER I WITH ACUTE
XK_Icircumflex => 0x00ce, #=  U+00CE LATIN CAPITAL LETTER I WITH CIRCUMFLEX
XK_Idiaeresis => 0x00cf, #=  U+00CF LATIN CAPITAL LETTER I WITH DIAERESIS
XK_ETH => 0x00d0, #=  U+00D0 LATIN CAPITAL LETTER ETH
XK_Eth => 0x00d0, #=  deprecated
XK_Ntilde => 0x00d1, #=  U+00D1 LATIN CAPITAL LETTER N WITH TILDE
XK_Ograve => 0x00d2, #=  U+00D2 LATIN CAPITAL LETTER O WITH GRAVE
XK_Oacute => 0x00d3, #=  U+00D3 LATIN CAPITAL LETTER O WITH ACUTE
XK_Ocircumflex => 0x00d4, #=  U+00D4 LATIN CAPITAL LETTER O WITH CIRCUMFLEX
XK_Otilde => 0x00d5, #=  U+00D5 LATIN CAPITAL LETTER O WITH TILDE
XK_Odiaeresis => 0x00d6, #=  U+00D6 LATIN CAPITAL LETTER O WITH DIAERESIS
XK_multiply => 0x00d7, #=  U+00D7 MULTIPLICATION SIGN
XK_Oslash => 0x00d8, #=  U+00D8 LATIN CAPITAL LETTER O WITH STROKE
XK_Ooblique => 0x00d8, #=  U+00D8 LATIN CAPITAL LETTER O WITH STROKE
XK_Ugrave => 0x00d9, #=  U+00D9 LATIN CAPITAL LETTER U WITH GRAVE
XK_Uacute => 0x00da, #=  U+00DA LATIN CAPITAL LETTER U WITH ACUTE
XK_Ucircumflex => 0x00db, #=  U+00DB LATIN CAPITAL LETTER U WITH CIRCUMFLEX
XK_Udiaeresis => 0x00dc, #=  U+00DC LATIN CAPITAL LETTER U WITH DIAERESIS
XK_Yacute => 0x00dd, #=  U+00DD LATIN CAPITAL LETTER Y WITH ACUTE
XK_THORN => 0x00de, #=  U+00DE LATIN CAPITAL LETTER THORN
XK_Thorn => 0x00de, #=  deprecated
XK_ssharp => 0x00df, #=  U+00DF LATIN SMALL LETTER SHARP S
XK_agrave => 0x00e0, #=  U+00E0 LATIN SMALL LETTER A WITH GRAVE
XK_aacute => 0x00e1, #=  U+00E1 LATIN SMALL LETTER A WITH ACUTE
XK_acircumflex => 0x00e2, #=  U+00E2 LATIN SMALL LETTER A WITH CIRCUMFLEX
XK_atilde => 0x00e3, #=  U+00E3 LATIN SMALL LETTER A WITH TILDE
XK_adiaeresis => 0x00e4, #=  U+00E4 LATIN SMALL LETTER A WITH DIAERESIS
XK_aring => 0x00e5, #=  U+00E5 LATIN SMALL LETTER A WITH RING ABOVE
XK_ae => 0x00e6, #=  U+00E6 LATIN SMALL LETTER AE
XK_ccedilla => 0x00e7, #=  U+00E7 LATIN SMALL LETTER C WITH CEDILLA
XK_egrave => 0x00e8, #=  U+00E8 LATIN SMALL LETTER E WITH GRAVE
XK_eacute => 0x00e9, #=  U+00E9 LATIN SMALL LETTER E WITH ACUTE
XK_ecircumflex => 0x00ea, #=  U+00EA LATIN SMALL LETTER E WITH CIRCUMFLEX
XK_ediaeresis => 0x00eb, #=  U+00EB LATIN SMALL LETTER E WITH DIAERESIS
XK_igrave => 0x00ec, #=  U+00EC LATIN SMALL LETTER I WITH GRAVE
XK_iacute => 0x00ed, #=  U+00ED LATIN SMALL LETTER I WITH ACUTE
XK_icircumflex => 0x00ee, #=  U+00EE LATIN SMALL LETTER I WITH CIRCUMFLEX
XK_idiaeresis => 0x00ef, #=  U+00EF LATIN SMALL LETTER I WITH DIAERESIS
XK_eth => 0x00f0, #=  U+00F0 LATIN SMALL LETTER ETH
XK_ntilde => 0x00f1, #=  U+00F1 LATIN SMALL LETTER N WITH TILDE
XK_ograve => 0x00f2, #=  U+00F2 LATIN SMALL LETTER O WITH GRAVE
XK_oacute => 0x00f3, #=  U+00F3 LATIN SMALL LETTER O WITH ACUTE
XK_ocircumflex => 0x00f4, #=  U+00F4 LATIN SMALL LETTER O WITH CIRCUMFLEX
XK_otilde => 0x00f5, #=  U+00F5 LATIN SMALL LETTER O WITH TILDE
XK_odiaeresis => 0x00f6, #=  U+00F6 LATIN SMALL LETTER O WITH DIAERESIS
XK_division => 0x00f7, #=  U+00F7 DIVISION SIGN
XK_oslash => 0x00f8, #=  U+00F8 LATIN SMALL LETTER O WITH STROKE
XK_ooblique => 0x00f8, #=  U+00F8 LATIN SMALL LETTER O WITH STROKE
XK_ugrave => 0x00f9, #=  U+00F9 LATIN SMALL LETTER U WITH GRAVE
XK_uacute => 0x00fa, #=  U+00FA LATIN SMALL LETTER U WITH ACUTE
XK_ucircumflex => 0x00fb, #=  U+00FB LATIN SMALL LETTER U WITH CIRCUMFLEX
XK_udiaeresis => 0x00fc, #=  U+00FC LATIN SMALL LETTER U WITH DIAERESIS
XK_yacute => 0x00fd, #=  U+00FD LATIN SMALL LETTER Y WITH ACUTE
XK_thorn => 0x00fe, #=  U+00FE LATIN SMALL LETTER THORN
XK_ydiaeresis => 0x00ff, #=  U+00FF LATIN SMALL LETTER Y WITH DIAERESIS
#endif /* XK_LATIN1

#
# Latin 2
# Byte 3 = 1
#

#ifdef XK_LATIN2
XK_Aogonek => 0x01a1, #=  U+0104 LATIN CAPITAL LETTER A WITH OGONEK
XK_breve => 0x01a2, #=  U+02D8 BREVE
XK_Lstroke => 0x01a3, #=  U+0141 LATIN CAPITAL LETTER L WITH STROKE
XK_Lcaron => 0x01a5, #=  U+013D LATIN CAPITAL LETTER L WITH CARON
XK_Sacute => 0x01a6, #=  U+015A LATIN CAPITAL LETTER S WITH ACUTE
XK_Scaron => 0x01a9, #=  U+0160 LATIN CAPITAL LETTER S WITH CARON
XK_Scedilla => 0x01aa, #=  U+015E LATIN CAPITAL LETTER S WITH CEDILLA
XK_Tcaron => 0x01ab, #=  U+0164 LATIN CAPITAL LETTER T WITH CARON
XK_Zacute => 0x01ac, #=  U+0179 LATIN CAPITAL LETTER Z WITH ACUTE
XK_Zcaron => 0x01ae, #=  U+017D LATIN CAPITAL LETTER Z WITH CARON
XK_Zabovedot => 0x01af, #=  U+017B LATIN CAPITAL LETTER Z WITH DOT ABOVE
XK_aogonek => 0x01b1, #=  U+0105 LATIN SMALL LETTER A WITH OGONEK
XK_ogonek => 0x01b2, #=  U+02DB OGONEK
XK_lstroke => 0x01b3, #=  U+0142 LATIN SMALL LETTER L WITH STROKE
XK_lcaron => 0x01b5, #=  U+013E LATIN SMALL LETTER L WITH CARON
XK_sacute => 0x01b6, #=  U+015B LATIN SMALL LETTER S WITH ACUTE
XK_caron => 0x01b7, #=  U+02C7 CARON
XK_scaron => 0x01b9, #=  U+0161 LATIN SMALL LETTER S WITH CARON
XK_scedilla => 0x01ba, #=  U+015F LATIN SMALL LETTER S WITH CEDILLA
XK_tcaron => 0x01bb, #=  U+0165 LATIN SMALL LETTER T WITH CARON
XK_zacute => 0x01bc, #=  U+017A LATIN SMALL LETTER Z WITH ACUTE
XK_doubleacute => 0x01bd, #=  U+02DD DOUBLE ACUTE ACCENT
XK_zcaron => 0x01be, #=  U+017E LATIN SMALL LETTER Z WITH CARON
XK_zabovedot => 0x01bf, #=  U+017C LATIN SMALL LETTER Z WITH DOT ABOVE
XK_Racute => 0x01c0, #=  U+0154 LATIN CAPITAL LETTER R WITH ACUTE
XK_Abreve => 0x01c3, #=  U+0102 LATIN CAPITAL LETTER A WITH BREVE
XK_Lacute => 0x01c5, #=  U+0139 LATIN CAPITAL LETTER L WITH ACUTE
XK_Cacute => 0x01c6, #=  U+0106 LATIN CAPITAL LETTER C WITH ACUTE
XK_Ccaron => 0x01c8, #=  U+010C LATIN CAPITAL LETTER C WITH CARON
XK_Eogonek => 0x01ca, #=  U+0118 LATIN CAPITAL LETTER E WITH OGONEK
XK_Ecaron => 0x01cc, #=  U+011A LATIN CAPITAL LETTER E WITH CARON
XK_Dcaron => 0x01cf, #=  U+010E LATIN CAPITAL LETTER D WITH CARON
XK_Dstroke => 0x01d0, #=  U+0110 LATIN CAPITAL LETTER D WITH STROKE
XK_Nacute => 0x01d1, #=  U+0143 LATIN CAPITAL LETTER N WITH ACUTE
XK_Ncaron => 0x01d2, #=  U+0147 LATIN CAPITAL LETTER N WITH CARON
XK_Odoubleacute => 0x01d5, #=  U+0150 LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
XK_Rcaron => 0x01d8, #=  U+0158 LATIN CAPITAL LETTER R WITH CARON
XK_Uring => 0x01d9, #=  U+016E LATIN CAPITAL LETTER U WITH RING ABOVE
XK_Udoubleacute => 0x01db, #=  U+0170 LATIN CAPITAL LETTER U WITH DOUBLE ACUTE
XK_Tcedilla => 0x01de, #=  U+0162 LATIN CAPITAL LETTER T WITH CEDILLA
XK_racute => 0x01e0, #=  U+0155 LATIN SMALL LETTER R WITH ACUTE
XK_abreve => 0x01e3, #=  U+0103 LATIN SMALL LETTER A WITH BREVE
XK_lacute => 0x01e5, #=  U+013A LATIN SMALL LETTER L WITH ACUTE
XK_cacute => 0x01e6, #=  U+0107 LATIN SMALL LETTER C WITH ACUTE
XK_ccaron => 0x01e8, #=  U+010D LATIN SMALL LETTER C WITH CARON
XK_eogonek => 0x01ea, #=  U+0119 LATIN SMALL LETTER E WITH OGONEK
XK_ecaron => 0x01ec, #=  U+011B LATIN SMALL LETTER E WITH CARON
XK_dcaron => 0x01ef, #=  U+010F LATIN SMALL LETTER D WITH CARON
XK_dstroke => 0x01f0, #=  U+0111 LATIN SMALL LETTER D WITH STROKE
XK_nacute => 0x01f1, #=  U+0144 LATIN SMALL LETTER N WITH ACUTE
XK_ncaron => 0x01f2, #=  U+0148 LATIN SMALL LETTER N WITH CARON
XK_odoubleacute => 0x01f5, #=  U+0151 LATIN SMALL LETTER O WITH DOUBLE ACUTE
XK_rcaron => 0x01f8, #=  U+0159 LATIN SMALL LETTER R WITH CARON
XK_uring => 0x01f9, #=  U+016F LATIN SMALL LETTER U WITH RING ABOVE
XK_udoubleacute => 0x01fb, #=  U+0171 LATIN SMALL LETTER U WITH DOUBLE ACUTE
XK_tcedilla => 0x01fe, #=  U+0163 LATIN SMALL LETTER T WITH CEDILLA
XK_abovedot => 0x01ff, #=  U+02D9 DOT ABOVE
#endif /* XK_LATIN2

#
# Latin 3
# Byte 3 = 2
#

#ifdef XK_LATIN3
XK_Hstroke => 0x02a1, #=  U+0126 LATIN CAPITAL LETTER H WITH STROKE
XK_Hcircumflex => 0x02a6, #=  U+0124 LATIN CAPITAL LETTER H WITH CIRCUMFLEX
XK_Iabovedot => 0x02a9, #=  U+0130 LATIN CAPITAL LETTER I WITH DOT ABOVE
XK_Gbreve => 0x02ab, #=  U+011E LATIN CAPITAL LETTER G WITH BREVE
XK_Jcircumflex => 0x02ac, #=  U+0134 LATIN CAPITAL LETTER J WITH CIRCUMFLEX
XK_hstroke => 0x02b1, #=  U+0127 LATIN SMALL LETTER H WITH STROKE
XK_hcircumflex => 0x02b6, #=  U+0125 LATIN SMALL LETTER H WITH CIRCUMFLEX
XK_idotless => 0x02b9, #=  U+0131 LATIN SMALL LETTER DOTLESS I
XK_gbreve => 0x02bb, #=  U+011F LATIN SMALL LETTER G WITH BREVE
XK_jcircumflex => 0x02bc, #=  U+0135 LATIN SMALL LETTER J WITH CIRCUMFLEX
XK_Cabovedot => 0x02c5, #=  U+010A LATIN CAPITAL LETTER C WITH DOT ABOVE
XK_Ccircumflex => 0x02c6, #=  U+0108 LATIN CAPITAL LETTER C WITH CIRCUMFLEX
XK_Gabovedot => 0x02d5, #=  U+0120 LATIN CAPITAL LETTER G WITH DOT ABOVE
XK_Gcircumflex => 0x02d8, #=  U+011C LATIN CAPITAL LETTER G WITH CIRCUMFLEX
XK_Ubreve => 0x02dd, #=  U+016C LATIN CAPITAL LETTER U WITH BREVE
XK_Scircumflex => 0x02de, #=  U+015C LATIN CAPITAL LETTER S WITH CIRCUMFLEX
XK_cabovedot => 0x02e5, #=  U+010B LATIN SMALL LETTER C WITH DOT ABOVE
XK_ccircumflex => 0x02e6, #=  U+0109 LATIN SMALL LETTER C WITH CIRCUMFLEX
XK_gabovedot => 0x02f5, #=  U+0121 LATIN SMALL LETTER G WITH DOT ABOVE
XK_gcircumflex => 0x02f8, #=  U+011D LATIN SMALL LETTER G WITH CIRCUMFLEX
XK_ubreve => 0x02fd, #=  U+016D LATIN SMALL LETTER U WITH BREVE
XK_scircumflex => 0x02fe, #=  U+015D LATIN SMALL LETTER S WITH CIRCUMFLEX
#endif /* XK_LATIN3


#
# Latin 4
# Byte 3 = 3
#

#ifdef XK_LATIN4
XK_kra => 0x03a2, #=  U+0138 LATIN SMALL LETTER KRA
XK_kappa => 0x03a2, #=  deprecated
XK_Rcedilla => 0x03a3, #=  U+0156 LATIN CAPITAL LETTER R WITH CEDILLA
XK_Itilde => 0x03a5, #=  U+0128 LATIN CAPITAL LETTER I WITH TILDE
XK_Lcedilla => 0x03a6, #=  U+013B LATIN CAPITAL LETTER L WITH CEDILLA
XK_Emacron => 0x03aa, #=  U+0112 LATIN CAPITAL LETTER E WITH MACRON
XK_Gcedilla => 0x03ab, #=  U+0122 LATIN CAPITAL LETTER G WITH CEDILLA
XK_Tslash => 0x03ac, #=  U+0166 LATIN CAPITAL LETTER T WITH STROKE
XK_rcedilla => 0x03b3, #=  U+0157 LATIN SMALL LETTER R WITH CEDILLA
XK_itilde => 0x03b5, #=  U+0129 LATIN SMALL LETTER I WITH TILDE
XK_lcedilla => 0x03b6, #=  U+013C LATIN SMALL LETTER L WITH CEDILLA
XK_emacron => 0x03ba, #=  U+0113 LATIN SMALL LETTER E WITH MACRON
XK_gcedilla => 0x03bb, #=  U+0123 LATIN SMALL LETTER G WITH CEDILLA
XK_tslash => 0x03bc, #=  U+0167 LATIN SMALL LETTER T WITH STROKE
XK_ENG => 0x03bd, #=  U+014A LATIN CAPITAL LETTER ENG
XK_eng => 0x03bf, #=  U+014B LATIN SMALL LETTER ENG
XK_Amacron => 0x03c0, #=  U+0100 LATIN CAPITAL LETTER A WITH MACRON
XK_Iogonek => 0x03c7, #=  U+012E LATIN CAPITAL LETTER I WITH OGONEK
XK_Eabovedot => 0x03cc, #=  U+0116 LATIN CAPITAL LETTER E WITH DOT ABOVE
XK_Imacron => 0x03cf, #=  U+012A LATIN CAPITAL LETTER I WITH MACRON
XK_Ncedilla => 0x03d1, #=  U+0145 LATIN CAPITAL LETTER N WITH CEDILLA
XK_Omacron => 0x03d2, #=  U+014C LATIN CAPITAL LETTER O WITH MACRON
XK_Kcedilla => 0x03d3, #=  U+0136 LATIN CAPITAL LETTER K WITH CEDILLA
XK_Uogonek => 0x03d9, #=  U+0172 LATIN CAPITAL LETTER U WITH OGONEK
XK_Utilde => 0x03dd, #=  U+0168 LATIN CAPITAL LETTER U WITH TILDE
XK_Umacron => 0x03de, #=  U+016A LATIN CAPITAL LETTER U WITH MACRON
XK_amacron => 0x03e0, #=  U+0101 LATIN SMALL LETTER A WITH MACRON
XK_iogonek => 0x03e7, #=  U+012F LATIN SMALL LETTER I WITH OGONEK
XK_eabovedot => 0x03ec, #=  U+0117 LATIN SMALL LETTER E WITH DOT ABOVE
XK_imacron => 0x03ef, #=  U+012B LATIN SMALL LETTER I WITH MACRON
XK_ncedilla => 0x03f1, #=  U+0146 LATIN SMALL LETTER N WITH CEDILLA
XK_omacron => 0x03f2, #=  U+014D LATIN SMALL LETTER O WITH MACRON
XK_kcedilla => 0x03f3, #=  U+0137 LATIN SMALL LETTER K WITH CEDILLA
XK_uogonek => 0x03f9, #=  U+0173 LATIN SMALL LETTER U WITH OGONEK
XK_utilde => 0x03fd, #=  U+0169 LATIN SMALL LETTER U WITH TILDE
XK_umacron => 0x03fe, #=  U+016B LATIN SMALL LETTER U WITH MACRON
#endif /* XK_LATIN4

#
# Latin 8
#
#ifdef XK_LATIN8
XK_Wcircumflex => 0x1000174, #=  U+0174 LATIN CAPITAL LETTER W WITH CIRCUMFLEX
XK_wcircumflex => 0x1000175, #=  U+0175 LATIN SMALL LETTER W WITH CIRCUMFLEX
XK_Ycircumflex => 0x1000176, #=  U+0176 LATIN CAPITAL LETTER Y WITH CIRCUMFLEX
XK_ycircumflex => 0x1000177, #=  U+0177 LATIN SMALL LETTER Y WITH CIRCUMFLEX
XK_Babovedot => 0x1001e02, #=  U+1E02 LATIN CAPITAL LETTER B WITH DOT ABOVE
XK_babovedot => 0x1001e03, #=  U+1E03 LATIN SMALL LETTER B WITH DOT ABOVE
XK_Dabovedot => 0x1001e0a, #=  U+1E0A LATIN CAPITAL LETTER D WITH DOT ABOVE
XK_dabovedot => 0x1001e0b, #=  U+1E0B LATIN SMALL LETTER D WITH DOT ABOVE
XK_Fabovedot => 0x1001e1e, #=  U+1E1E LATIN CAPITAL LETTER F WITH DOT ABOVE
XK_fabovedot => 0x1001e1f, #=  U+1E1F LATIN SMALL LETTER F WITH DOT ABOVE
XK_Mabovedot => 0x1001e40, #=  U+1E40 LATIN CAPITAL LETTER M WITH DOT ABOVE
XK_mabovedot => 0x1001e41, #=  U+1E41 LATIN SMALL LETTER M WITH DOT ABOVE
XK_Pabovedot => 0x1001e56, #=  U+1E56 LATIN CAPITAL LETTER P WITH DOT ABOVE
XK_pabovedot => 0x1001e57, #=  U+1E57 LATIN SMALL LETTER P WITH DOT ABOVE
XK_Sabovedot => 0x1001e60, #=  U+1E60 LATIN CAPITAL LETTER S WITH DOT ABOVE
XK_sabovedot => 0x1001e61, #=  U+1E61 LATIN SMALL LETTER S WITH DOT ABOVE
XK_Tabovedot => 0x1001e6a, #=  U+1E6A LATIN CAPITAL LETTER T WITH DOT ABOVE
XK_tabovedot => 0x1001e6b, #=  U+1E6B LATIN SMALL LETTER T WITH DOT ABOVE
XK_Wgrave => 0x1001e80, #=  U+1E80 LATIN CAPITAL LETTER W WITH GRAVE
XK_wgrave => 0x1001e81, #=  U+1E81 LATIN SMALL LETTER W WITH GRAVE
XK_Wacute => 0x1001e82, #=  U+1E82 LATIN CAPITAL LETTER W WITH ACUTE
XK_wacute => 0x1001e83, #=  U+1E83 LATIN SMALL LETTER W WITH ACUTE
XK_Wdiaeresis => 0x1001e84, #=  U+1E84 LATIN CAPITAL LETTER W WITH DIAERESIS
XK_wdiaeresis => 0x1001e85, #=  U+1E85 LATIN SMALL LETTER W WITH DIAERESIS
XK_Ygrave => 0x1001ef2, #=  U+1EF2 LATIN CAPITAL LETTER Y WITH GRAVE
XK_ygrave => 0x1001ef3, #=  U+1EF3 LATIN SMALL LETTER Y WITH GRAVE
#endif /* XK_LATIN8

#
# Latin 9
# Byte 3 = 0x13
#

#ifdef XK_LATIN9
XK_OE => 0x13bc, #=  U+0152 LATIN CAPITAL LIGATURE OE
XK_oe => 0x13bd, #=  U+0153 LATIN SMALL LIGATURE OE
XK_Ydiaeresis => 0x13be, #=  U+0178 LATIN CAPITAL LETTER Y WITH DIAERESIS
#endif /* XK_LATIN9

#
# Katakana
# Byte 3 = 4
#

#ifdef XK_KATAKANA
XK_overline => 0x047e, #=  U+203E OVERLINE
XK_kana_fullstop => 0x04a1, #=  U+3002 IDEOGRAPHIC FULL STOP
XK_kana_openingbracket => 0x04a2, #=  U+300C LEFT CORNER BRACKET
XK_kana_closingbracket => 0x04a3, #=  U+300D RIGHT CORNER BRACKET
XK_kana_comma => 0x04a4, #=  U+3001 IDEOGRAPHIC COMMA
XK_kana_conjunctive => 0x04a5, #=  U+30FB KATAKANA MIDDLE DOT
XK_kana_middledot => 0x04a5, #=  deprecated
XK_kana_WO => 0x04a6, #=  U+30F2 KATAKANA LETTER WO
XK_kana_a => 0x04a7, #=  U+30A1 KATAKANA LETTER SMALL A
XK_kana_i => 0x04a8, #=  U+30A3 KATAKANA LETTER SMALL I
XK_kana_u => 0x04a9, #=  U+30A5 KATAKANA LETTER SMALL U
XK_kana_e => 0x04aa, #=  U+30A7 KATAKANA LETTER SMALL E
XK_kana_o => 0x04ab, #=  U+30A9 KATAKANA LETTER SMALL O
XK_kana_ya => 0x04ac, #=  U+30E3 KATAKANA LETTER SMALL YA
XK_kana_yu => 0x04ad, #=  U+30E5 KATAKANA LETTER SMALL YU
XK_kana_yo => 0x04ae, #=  U+30E7 KATAKANA LETTER SMALL YO
XK_kana_tsu => 0x04af, #=  U+30C3 KATAKANA LETTER SMALL TU
XK_kana_tu => 0x04af, #=  deprecated
XK_prolongedsound => 0x04b0, #=  U+30FC KATAKANA-HIRAGANA PROLONGED SOUND MARK
XK_kana_A => 0x04b1, #=  U+30A2 KATAKANA LETTER A
XK_kana_I => 0x04b2, #=  U+30A4 KATAKANA LETTER I
XK_kana_U => 0x04b3, #=  U+30A6 KATAKANA LETTER U
XK_kana_E => 0x04b4, #=  U+30A8 KATAKANA LETTER E
XK_kana_O => 0x04b5, #=  U+30AA KATAKANA LETTER O
XK_kana_KA => 0x04b6, #=  U+30AB KATAKANA LETTER KA
XK_kana_KI => 0x04b7, #=  U+30AD KATAKANA LETTER KI
XK_kana_KU => 0x04b8, #=  U+30AF KATAKANA LETTER KU
XK_kana_KE => 0x04b9, #=  U+30B1 KATAKANA LETTER KE
XK_kana_KO => 0x04ba, #=  U+30B3 KATAKANA LETTER KO
XK_kana_SA => 0x04bb, #=  U+30B5 KATAKANA LETTER SA
XK_kana_SHI => 0x04bc, #=  U+30B7 KATAKANA LETTER SI
XK_kana_SU => 0x04bd, #=  U+30B9 KATAKANA LETTER SU
XK_kana_SE => 0x04be, #=  U+30BB KATAKANA LETTER SE
XK_kana_SO => 0x04bf, #=  U+30BD KATAKANA LETTER SO
XK_kana_TA => 0x04c0, #=  U+30BF KATAKANA LETTER TA
XK_kana_CHI => 0x04c1, #=  U+30C1 KATAKANA LETTER TI
XK_kana_TI => 0x04c1, #=  deprecated
XK_kana_TSU => 0x04c2, #=  U+30C4 KATAKANA LETTER TU
XK_kana_TU => 0x04c2, #=  deprecated
XK_kana_TE => 0x04c3, #=  U+30C6 KATAKANA LETTER TE
XK_kana_TO => 0x04c4, #=  U+30C8 KATAKANA LETTER TO
XK_kana_NA => 0x04c5, #=  U+30CA KATAKANA LETTER NA
XK_kana_NI => 0x04c6, #=  U+30CB KATAKANA LETTER NI
XK_kana_NU => 0x04c7, #=  U+30CC KATAKANA LETTER NU
XK_kana_NE => 0x04c8, #=  U+30CD KATAKANA LETTER NE
XK_kana_NO => 0x04c9, #=  U+30CE KATAKANA LETTER NO
XK_kana_HA => 0x04ca, #=  U+30CF KATAKANA LETTER HA
XK_kana_HI => 0x04cb, #=  U+30D2 KATAKANA LETTER HI
XK_kana_FU => 0x04cc, #=  U+30D5 KATAKANA LETTER HU
XK_kana_HU => 0x04cc, #=  deprecated
XK_kana_HE => 0x04cd, #=  U+30D8 KATAKANA LETTER HE
XK_kana_HO => 0x04ce, #=  U+30DB KATAKANA LETTER HO
XK_kana_MA => 0x04cf, #=  U+30DE KATAKANA LETTER MA
XK_kana_MI => 0x04d0, #=  U+30DF KATAKANA LETTER MI
XK_kana_MU => 0x04d1, #=  U+30E0 KATAKANA LETTER MU
XK_kana_ME => 0x04d2, #=  U+30E1 KATAKANA LETTER ME
XK_kana_MO => 0x04d3, #=  U+30E2 KATAKANA LETTER MO
XK_kana_YA => 0x04d4, #=  U+30E4 KATAKANA LETTER YA
XK_kana_YU => 0x04d5, #=  U+30E6 KATAKANA LETTER YU
XK_kana_YO => 0x04d6, #=  U+30E8 KATAKANA LETTER YO
XK_kana_RA => 0x04d7, #=  U+30E9 KATAKANA LETTER RA
XK_kana_RI => 0x04d8, #=  U+30EA KATAKANA LETTER RI
XK_kana_RU => 0x04d9, #=  U+30EB KATAKANA LETTER RU
XK_kana_RE => 0x04da, #=  U+30EC KATAKANA LETTER RE
XK_kana_RO => 0x04db, #=  U+30ED KATAKANA LETTER RO
XK_kana_WA => 0x04dc, #=  U+30EF KATAKANA LETTER WA
XK_kana_N => 0x04dd, #=  U+30F3 KATAKANA LETTER N
XK_voicedsound => 0x04de, #=  U+309B KATAKANA-HIRAGANA VOICED SOUND MARK
XK_semivoicedsound => 0x04df, #=  U+309C KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK
XK_kana_switch => 0xff7e, #=  Alias for mode_switch
#endif /* XK_KATAKANA

#
# Arabic
# Byte 3 = 5
#

#ifdef XK_ARABIC
XK_Farsi_0 => 0x10006f0, #=  U+06F0 EXTENDED ARABIC-INDIC DIGIT ZERO
XK_Farsi_1 => 0x10006f1, #=  U+06F1 EXTENDED ARABIC-INDIC DIGIT ONE
XK_Farsi_2 => 0x10006f2, #=  U+06F2 EXTENDED ARABIC-INDIC DIGIT TWO
XK_Farsi_3 => 0x10006f3, #=  U+06F3 EXTENDED ARABIC-INDIC DIGIT THREE
XK_Farsi_4 => 0x10006f4, #=  U+06F4 EXTENDED ARABIC-INDIC DIGIT FOUR
XK_Farsi_5 => 0x10006f5, #=  U+06F5 EXTENDED ARABIC-INDIC DIGIT FIVE
XK_Farsi_6 => 0x10006f6, #=  U+06F6 EXTENDED ARABIC-INDIC DIGIT SIX
XK_Farsi_7 => 0x10006f7, #=  U+06F7 EXTENDED ARABIC-INDIC DIGIT SEVEN
XK_Farsi_8 => 0x10006f8, #=  U+06F8 EXTENDED ARABIC-INDIC DIGIT EIGHT
XK_Farsi_9 => 0x10006f9, #=  U+06F9 EXTENDED ARABIC-INDIC DIGIT NINE
XK_Arabic_percent => 0x100066a, #=  U+066A ARABIC PERCENT SIGN
XK_Arabic_superscript_alef => 0x1000670, #=  U+0670 ARABIC LETTER SUPERSCRIPT ALEF
XK_Arabic_tteh => 0x1000679, #=  U+0679 ARABIC LETTER TTEH
XK_Arabic_peh => 0x100067e, #=  U+067E ARABIC LETTER PEH
XK_Arabic_tcheh => 0x1000686, #=  U+0686 ARABIC LETTER TCHEH
XK_Arabic_ddal => 0x1000688, #=  U+0688 ARABIC LETTER DDAL
XK_Arabic_rreh => 0x1000691, #=  U+0691 ARABIC LETTER RREH
XK_Arabic_comma => 0x05ac, #=  U+060C ARABIC COMMA
XK_Arabic_fullstop => 0x10006d4, #=  U+06D4 ARABIC FULL STOP
XK_Arabic_0 => 0x1000660, #=  U+0660 ARABIC-INDIC DIGIT ZERO
XK_Arabic_1 => 0x1000661, #=  U+0661 ARABIC-INDIC DIGIT ONE
XK_Arabic_2 => 0x1000662, #=  U+0662 ARABIC-INDIC DIGIT TWO
XK_Arabic_3 => 0x1000663, #=  U+0663 ARABIC-INDIC DIGIT THREE
XK_Arabic_4 => 0x1000664, #=  U+0664 ARABIC-INDIC DIGIT FOUR
XK_Arabic_5 => 0x1000665, #=  U+0665 ARABIC-INDIC DIGIT FIVE
XK_Arabic_6 => 0x1000666, #=  U+0666 ARABIC-INDIC DIGIT SIX
XK_Arabic_7 => 0x1000667, #=  U+0667 ARABIC-INDIC DIGIT SEVEN
XK_Arabic_8 => 0x1000668, #=  U+0668 ARABIC-INDIC DIGIT EIGHT
XK_Arabic_9 => 0x1000669, #=  U+0669 ARABIC-INDIC DIGIT NINE
XK_Arabic_semicolon => 0x05bb, #=  U+061B ARABIC SEMICOLON
XK_Arabic_question_mark => 0x05bf, #=  U+061F ARABIC QUESTION MARK
XK_Arabic_hamza => 0x05c1, #=  U+0621 ARABIC LETTER HAMZA
XK_Arabic_maddaonalef => 0x05c2, #=  U+0622 ARABIC LETTER ALEF WITH MADDA ABOVE
XK_Arabic_hamzaonalef => 0x05c3, #=  U+0623 ARABIC LETTER ALEF WITH HAMZA ABOVE
XK_Arabic_hamzaonwaw => 0x05c4, #=  U+0624 ARABIC LETTER WAW WITH HAMZA ABOVE
XK_Arabic_hamzaunderalef => 0x05c5, #=  U+0625 ARABIC LETTER ALEF WITH HAMZA BELOW
XK_Arabic_hamzaonyeh => 0x05c6, #=  U+0626 ARABIC LETTER YEH WITH HAMZA ABOVE
XK_Arabic_alef => 0x05c7, #=  U+0627 ARABIC LETTER ALEF
XK_Arabic_beh => 0x05c8, #=  U+0628 ARABIC LETTER BEH
XK_Arabic_tehmarbuta => 0x05c9, #=  U+0629 ARABIC LETTER TEH MARBUTA
XK_Arabic_teh => 0x05ca, #=  U+062A ARABIC LETTER TEH
XK_Arabic_theh => 0x05cb, #=  U+062B ARABIC LETTER THEH
XK_Arabic_jeem => 0x05cc, #=  U+062C ARABIC LETTER JEEM
XK_Arabic_hah => 0x05cd, #=  U+062D ARABIC LETTER HAH
XK_Arabic_khah => 0x05ce, #=  U+062E ARABIC LETTER KHAH
XK_Arabic_dal => 0x05cf, #=  U+062F ARABIC LETTER DAL
XK_Arabic_thal => 0x05d0, #=  U+0630 ARABIC LETTER THAL
XK_Arabic_ra => 0x05d1, #=  U+0631 ARABIC LETTER REH
XK_Arabic_zain => 0x05d2, #=  U+0632 ARABIC LETTER ZAIN
XK_Arabic_seen => 0x05d3, #=  U+0633 ARABIC LETTER SEEN
XK_Arabic_sheen => 0x05d4, #=  U+0634 ARABIC LETTER SHEEN
XK_Arabic_sad => 0x05d5, #=  U+0635 ARABIC LETTER SAD
XK_Arabic_dad => 0x05d6, #=  U+0636 ARABIC LETTER DAD
XK_Arabic_tah => 0x05d7, #=  U+0637 ARABIC LETTER TAH
XK_Arabic_zah => 0x05d8, #=  U+0638 ARABIC LETTER ZAH
XK_Arabic_ain => 0x05d9, #=  U+0639 ARABIC LETTER AIN
XK_Arabic_ghain => 0x05da, #=  U+063A ARABIC LETTER GHAIN
XK_Arabic_tatweel => 0x05e0, #=  U+0640 ARABIC TATWEEL
XK_Arabic_feh => 0x05e1, #=  U+0641 ARABIC LETTER FEH
XK_Arabic_qaf => 0x05e2, #=  U+0642 ARABIC LETTER QAF
XK_Arabic_kaf => 0x05e3, #=  U+0643 ARABIC LETTER KAF
XK_Arabic_lam => 0x05e4, #=  U+0644 ARABIC LETTER LAM
XK_Arabic_meem => 0x05e5, #=  U+0645 ARABIC LETTER MEEM
XK_Arabic_noon => 0x05e6, #=  U+0646 ARABIC LETTER NOON
XK_Arabic_ha => 0x05e7, #=  U+0647 ARABIC LETTER HEH
XK_Arabic_heh => 0x05e7, #=  deprecated
XK_Arabic_waw => 0x05e8, #=  U+0648 ARABIC LETTER WAW
XK_Arabic_alefmaksura => 0x05e9, #=  U+0649 ARABIC LETTER ALEF MAKSURA
XK_Arabic_yeh => 0x05ea, #=  U+064A ARABIC LETTER YEH
XK_Arabic_fathatan => 0x05eb, #=  U+064B ARABIC FATHATAN
XK_Arabic_dammatan => 0x05ec, #=  U+064C ARABIC DAMMATAN
XK_Arabic_kasratan => 0x05ed, #=  U+064D ARABIC KASRATAN
XK_Arabic_fatha => 0x05ee, #=  U+064E ARABIC FATHA
XK_Arabic_damma => 0x05ef, #=  U+064F ARABIC DAMMA
XK_Arabic_kasra => 0x05f0, #=  U+0650 ARABIC KASRA
XK_Arabic_shadda => 0x05f1, #=  U+0651 ARABIC SHADDA
XK_Arabic_sukun => 0x05f2, #=  U+0652 ARABIC SUKUN
XK_Arabic_madda_above => 0x1000653, #=  U+0653 ARABIC MADDAH ABOVE
XK_Arabic_hamza_above => 0x1000654, #=  U+0654 ARABIC HAMZA ABOVE
XK_Arabic_hamza_below => 0x1000655, #=  U+0655 ARABIC HAMZA BELOW
XK_Arabic_jeh => 0x1000698, #=  U+0698 ARABIC LETTER JEH
XK_Arabic_veh => 0x10006a4, #=  U+06A4 ARABIC LETTER VEH
XK_Arabic_keheh => 0x10006a9, #=  U+06A9 ARABIC LETTER KEHEH
XK_Arabic_gaf => 0x10006af, #=  U+06AF ARABIC LETTER GAF
XK_Arabic_noon_ghunna => 0x10006ba, #=  U+06BA ARABIC LETTER NOON GHUNNA
XK_Arabic_heh_doachashmee => 0x10006be, #=  U+06BE ARABIC LETTER HEH DOACHASHMEE
XK_Farsi_yeh => 0x10006cc, #=  U+06CC ARABIC LETTER FARSI YEH
XK_Arabic_farsi_yeh => 0x10006cc, #=  U+06CC ARABIC LETTER FARSI YEH
XK_Arabic_yeh_baree => 0x10006d2, #=  U+06D2 ARABIC LETTER YEH BARREE
XK_Arabic_heh_goal => 0x10006c1, #=  U+06C1 ARABIC LETTER HEH GOAL
);

# vim: expandtab shiftwidth=4

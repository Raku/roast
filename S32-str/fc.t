use v6;
use Test;

plan 12;

# Simple
is 'BEEF \o/'.fc, 'beef \o/', '.fc on simple string in ASCII range works';
is 'ÝØÛ SMĚŁŁ'.fc, 'ýøû směłł', '.fc on string with non-growing case fold';

# Growing to multiple graphemes
is 'Scheiße!'.fc, 'scheisse!', '.fc on ß expands to ss';
is 'fish ŉ chips'.fc, 'fish ʼn chips', '.fc on ŉ expands to ʼn';
is 'Leﬀe'.fc, 'leffe', 'ligature ﬀ expands to ff on foldcase';
is 'Eﬃcient'.fc, 'efficient', 'ligature ﬃ expands to ffi on foldcase';

# Curious cases where a foldcase does expand to a base and combiner, but NFC
# (not even NFG) actually restores it, making it a no-op for NFG strings.
is 'ǰnthn'.fc, 'ǰnthn', 'ǰ foldcases to identity under NFG (1 combiner)';
is 'pΐvo'.fc, 'pΐvo', 'ΐ foldcases to identity under NFG (2 combiners)';

# Cases where foldcase expands to precomposed and another base.
is 'BᾈR'.fc, 'bἀιr', 'ᾈ foldcases to ἀι';
is 'BᾈR'.fc.chars, 4, 'ᾈ -> ἀι = 1 extra char';

# Case where foldcase expands to base, combiner, base, and we need to compose
# the first two to maintain NFG.
is 'oῷ!'.fc, 'oῶι!', 'ῷ foldcases to ῶι';
is 'oῷ!'.fc.chars, 4, 'ῷ -> ῶι = 1 extra char';

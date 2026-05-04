"""One-shot fix: replace literal LF inside .split('...') and .join('...')
with the proper Dart escape sequence (backslash + n).
"""
import sys

path = 'lib/features/cultural_content/widgets/share_card_renderer.dart'
with open(path, 'rb') as f:
    data = f.read()

# Use byte values directly — no shell escaping shenanigans.
LF = bytes([0x0a])              # 1 byte literal newline
ESCAPED = bytes([0x5c, 0x6e])    # 2 bytes: backslash + 'n'

# Pattern: ".split(' + LF + ')"
old_split = b".split('" + LF + b"')"
new_split = b".split('" + ESCAPED + b"')"
old_join = b".join('" + LF + b"')"
new_join = b".join('" + ESCAPED + b"')"

print(f"old_split: {len(old_split)} bytes hex={' '.join(f'{b:02x}' for b in old_split)}")
print(f"new_split: {len(new_split)} bytes hex={' '.join(f'{b:02x}' for b in new_split)}")

n_split = data.count(old_split)
n_join = data.count(old_join)
print(f"\nBefore: split={n_split}, join={n_join}")

data = data.replace(old_split, new_split).replace(old_join, new_join)

n_split_after = data.count(old_split)
n_join_after = data.count(old_join)
print(f"After:  split={n_split_after}, join={n_join_after}")
print(f"After:  escaped_split={data.count(new_split)}, escaped_join={data.count(new_join)}")

with open(path, 'wb') as f:
    f.write(data)
print(f"\nFile saved. Size: {len(data)} bytes.")

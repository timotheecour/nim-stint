# Mpint
# Copyright 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.

import  ./binary_ops/addsub_impl,
        ./binary_ops/mul_impl

export addsub_impl, mul_impl

when isMainModule:

  import typetraits
  import ./uint_init

  let a = toMpUint(10'u32)

  echo "a: " & $a
  echo "a+a: " & $(a+a)

  let z = a * a
  echo "a * a: " & $z # How did the result value change?
  echo "a * a type: " & $z.type.name

  # Compile without release: memory corruption
  # In release: no corruption
  # Comment out the "naiveMul" in mul_impl: no corruption
  echo "Is memory corrupted: " & $(z != toMpUint(100'u32))

# Output on my machine
#
# a: (lo: 10, hi: 0)
# +: (lo: 20, hi: 0)
# a+a: (lo: 20, hi: 0)
# naiveMul cast16:(lo: 100, hi: 0)
# naiveMul cast16:(lo: 0, hi: 0)
# naiveMul cast16:(lo: 0, hi: 0)
# +: (lo: 0, hi: 0)
# Within `*` result: (lo: 100, hi: 0)
# Within `*` result: MpUint[32]
# a * a: (lo: 100, hi: 1066)
# a * a type: MpUint[32]
# Is memory corrupted: true

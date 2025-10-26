%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo({
  "id": 3,
  "response": {
    "created": false,
    "success": true,
    "id": "a04gL00000A53cDQAR",
    "errors": []
  }
})
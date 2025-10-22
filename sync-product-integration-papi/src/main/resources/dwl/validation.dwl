%dw 2.0
output application/json

var validData = []
var invalidData = []


fun isValid(item) =
    !isBlank(item.id) and
    !isBlank(item.title) and
    !isBlank(item.price) and
    !isBlank(item.description) and
    !isBlank(item.category) and
    !isBlank(item.image) and
    !isEmpty(item.rating) and
    !isBlank(item.rating.rate) and
    !isBlank(item.rating.count)

---
{
    validData: payload filter (item) -> isValid(item),
    invalidData: payload filter (item) -> not isValid(item)
}

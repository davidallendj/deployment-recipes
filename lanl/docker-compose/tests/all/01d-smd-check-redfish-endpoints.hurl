# Check that fetching RedfishEndpoints without specifying an xname works.
GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints
# Response should have >0 entry with a successful return code.
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.[*]" count > 0

<?php
header('Content-Type: application/json');

echo '
{
  "dealerships": [{
      "name": "Dealer Name 1",
      "address": {
          "street": "2022 33rd St",
          "city": "New York",
          "state": "NY",
          "zipcode": 12345
      },
      "distance": {
          "value": 0.76,
          "unit": "miles"
      }
  }, {
      "name": "Dealer Name 2",
      "address": {
          "street": "2022 33rd St",
          "city": "New York",
          "state": "NY",
          "zipcode": 12321
      },
      "distance": {
          "value": 2.89,
          "unit": "miles"
      }
  }, {
      "name": "Dealer Name 3",
      "address": {
          "street": "2022 33rd St",
          "city": "New York",
          "state": "NY",
          "zipcode": 12312
      },
      "distance": {
          "value": 3.20,
          "unit": "miles"
      }
  }]
}';

?>

# Tags and their meanings

## Item Resource

### `negative_allowed`
Allow a resource's amount to be negative. 

#### Format:
key: `negative_allowed`
value: any

### `eats`
Consume food depending on the amount of this resource.

#### Format:
key: `negative_allowed`
value: any

### `food_mod`
How much to multiply the amount of this resource by to get food consumed per day.
Has no effect if the tag [`eats`](#`eats`) is not also present.

#### Format:
key: `food_mod`
value: float

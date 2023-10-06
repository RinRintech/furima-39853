# DB設計
## usersテーブル
| Column             | Type    | Option                    |
|--------------------|---------|---------------------------|
| id(PK)             | integer | null: false               |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| date_of_birth      | date    | null: false               |

### Association
- has_many :items

## itemsテーブル
| Column             | Type       | Option                         |
|--------------------|------------|--------------------------------|
| id(PK)             | integer    | null: false                    |
| name               | string     | null: false                    |
| descritption       | text       | null: false                    |
| price              | integer    | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| shipping_charge_id | integer    | null: false                    |
| shipping_date_id   | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| user(FK)           | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :buy

## buysテーブル
| Column             | Type       | Option                         |
|--------------------|------------|--------------------------------|
| items              | references | null: false, foreign_key: true |
| users              | references | null: false, foreign_key: true |

### Association
- belongs_to :item
- has_many :users




## deliveriesテーブル
| Column             | Type       | Option                         |
|--------------------|------------|--------------------------------|
| buys               | references | null: false, foreign_key: true |
| postal_code        | string     | null: false                    |
| prefecture_id      | string     | null: false                    |
| city_id            | string     | null: false                    |
| street_id          | string     | null: false                    |
| block_id           | string     | null: false                    |
| building_id        | string     |                                |
| tel                | string     | null: false                    |

### Association
- belongs_to :buy

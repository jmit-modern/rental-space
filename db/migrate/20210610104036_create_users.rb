class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      t.string :username, comment: "Username"
      t.string :first_name, null: false, comment: "First Name"
      t.string :last_name, null: false, comment: "Last Name"
      t.string :email, null: false, comment: "Email Address"
      t.string :password_digest, null: false, comment: "Password"
      t.integer :user_type, null: false, comment: "User Type (0:User, 1:Space Owner, 2: Experts, 3:Admin)"
      t.string :card_number, comment: "Card Number"
      t.string :photo, comment: "User photo"
      t.integer :status, default: 0, comment: "User Status (0: active, 1: deactive, 2: deleted)"
      t.datetime :last_login, comment: "Last Login"
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end

class ChangeDefaultValues < ActiveRecord::Migration[5.1]
  def change
    change_column_default :movies, :title, from: nil, to: ""
    change_column_default :movies, :wilson_score, from: nil, to: 1

    change_column_default :reviews, :rating, from: nil, to: 1
    change_column_default :reviews, :comment, from: nil, to: ""

    change_column_default :users, :email, from: nil, to: ""
  end
end

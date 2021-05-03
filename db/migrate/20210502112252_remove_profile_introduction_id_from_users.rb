class RemoveProfileIntroductionIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :profile_introduction_d, :string
  end
end

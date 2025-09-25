class CreateSupportRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :support_requests do |t|
      t.string :email, comment: "Email address of submitter"
      t.string :subject, comment: "Subject of submitter's email"
      t.string :body, comment: "Body of email"
      t.references :order, foreign_key: true, comment: "Most recent order, if applicable"
      t.timestamps
    end
  end
end

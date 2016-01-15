class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :status, :created_at, :task
  belongs_to :user

  def id
    object.encrypted_id
  end

  def created_at
    object.created_at.to_s
  end

  def task
    ActiveModel::Serializer::Adapter::FlattenJson.new(TaskSerializer.new(object.target)).as_json
  end
end

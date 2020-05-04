class ImageAttachmentsValidator < ActiveModel::Validator
  def validate(record)
    return unless record.description&.body&.attachments&.any?

    record.description.body.attachments.each do |attach|
      start_with_image_validation(attach, record)
      image_type_validation(attach, record)
      image_size_validation(attach, record)
    end
  end

  private

  def start_with_image_validation(attach, record)
    record.errors.add(:description, 'only images can be downloaded') unless attach.image?
  end

  def image_type_validation(attach, record)
    return if attach.content_type.in?(%w[image/jpeg image/png image/gif])

    record.errors.add(:description, 'image format is invalid')
  end

  def image_size_validation(attach, record)
    return unless attach.byte_size > 1.megabytes

    record.errors.add(:description, 'image byte size should by less than 1MB')
  end
end

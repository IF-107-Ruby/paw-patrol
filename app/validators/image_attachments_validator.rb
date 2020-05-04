class ImageAttachmentsValidator < ActiveModel::Validator
  def validate(record)
    return unless record.description.body&.attachments

    record.description.body.attachments.each do |attach|
      image_type_validation(attach, record)
      image_size_validation(attach, record)
    end
  end

  private

  def image_type_validation(attach, record)
    return if attach.content_type.in?(%w[image/jpeg image/png image/gif])

    record.errors.add(:description, 'image format is invalid')
  end

  def image_size_validation(attach, record)
    return unless attach.byte_size > 1.megabytes

    record.errors.add(:description, 'image byte size should by less than 1MB')
  end
end

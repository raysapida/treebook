# Paperclip::Validators::AttachmentSizeValidator references CHECKS from
# ActiveModel::Validations::NumericalityValidator, which was removed in Rails 7.0.
# Paperclip is unmaintained; this restores the constant it expects.
Paperclip::Validators::AttachmentSizeValidator::CHECKS = {
  greater_than: :>,
  greater_than_or_equal_to: :>=,
  equal_to: :==,
  less_than: :<,
  less_than_or_equal_to: :<=
}.freeze

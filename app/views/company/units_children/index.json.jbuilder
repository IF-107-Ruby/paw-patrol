json.partial! 'company/units/unit',
              collection: @units.includes(:responsible_user),
              as: :unit

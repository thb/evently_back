# frozen_string_literal: true

module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body).with_indifferent_access if response&.body.present?
  end
end

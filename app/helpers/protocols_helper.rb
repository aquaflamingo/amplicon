module ProtocolsHelper
  def has_favorited?(user, protocol)
    user.favorites.exists?(protocol.id)
  end

  def render_visibility_badge(proto)
    if @proto.private?
      content_tag :span, class: "badge rounded-pill bg-dark text-light" do
        "Private"
      end
    else
      content_tag :span, class: "badge rounded-pill  bg-light text-dark" do
        "Public"
      end 
    end
  end

  # Renders HTML Diff for a each change made the protocol in its version history
  def audit_version_diffs_for(proto)
    proto.own_and_associated_audits.map do |audit_item| 
      AuditDiff.new(audit_item).to_version_diff
    end
  end

  class Diff
    attr_reader :diff

    def initialize(first, second)
      @diff = Diffy::Diff.new(first, second)
    end

    def to_html
      diff.to_s(:html).html_safe
    end
  end

  class AuditDiff
    def initialize(audit_object) 
      @audit_object = audit_object
    end

    def to_version_diff
      # Iterate through all changes in the hash 
      # { 
      #    name => Diff, 
      #    description => Diff
      # }
      consolidated_changes.map do |change_key, change_values|
        if change_values.is_a?(String)
          # The creation event does not have a previous value 
          first, second = "No content", change_values
        else
          first, second = change_values
        end

        { change_key => Diff.new(first, second) }
      end.inject({}, :merge)
    end

    private
    # An audit change contains two origins of modification:
    #   * Protocol data modified directly on the Protocol table
    #   * Protocol data modified via association through rich text table
    # 
    # Combines both change sets together into a single hash
    #
    # @return [Hash] 
    def consolidated_changes
      direct_changes.merge(associated_changes)
    end
    
    # Transforms the associated changes for the +audit_object+ into
    # the same format as the audited_changes.
    def associated_changes
      associated = @audit_object.associated
      if associated.blank? || associated.empty?
        {}
      else
        {
          associated.name => ["", associated.body.to_plain_text]
        }
      end
    end

    # Returns all audited_changes 
    def direct_changes
      @audit_object.audited_changes
    end
  end
end

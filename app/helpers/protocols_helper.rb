# frozen_string_literal: true

module ProtocolsHelper
  def user_protocol_header(proto, css: '')
    content_tag :h5, class: css do
      concat(link_to(proto.owner.username, user_path(proto.owner)))
      concat(' / ')
      concat(link_to(proto.name, protocol_path(proto)))
    end
  end

  def has_favorited?(user, protocol)
    user.favorites.exists?(protocol.id)
  end

  def visibility_badge(_proto)
    if @proto.private?
      content_tag :span, class: 'badge rounded-pill bg-dark text-light' do
        'Private'
      end
    else
      content_tag :span, class: 'badge rounded-pill  bg-light text-dark' do
        'Public'
      end
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
          first = 'No content'
          second = change_values
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
      audited_changes.merge(associated_audit_changes)
    end

    # Transforms the associated changes for the +audit_object+ into
    # the same format as the audited_changes.
    def associated_audit_changes
      associated = @audit_object.associated
      if associated.blank? || associated.empty?
        {}
      else
        # TODO, how do you associate the RichText audit events
        # with the events from the Protocol change. You cannot use
        # versions, because, you may make a Protocol.title change
        # but not rich text change. The result is no incrementing for
        # other attributes
        #
        # Maybe, we decide NOT to audit the base protocol attributes, and just
        # the diffs for rich text because that's really all you would care about right?
        associated.audits.first.audited_changes
      end
    end

    # Returns all audited_changes
    def audited_changes
      @audit_object.audited_changes
    end
  end
end

require 'redirector'

Redirector::RedirectRule.class_eval do
  def self.match_sql_condition
    <<-SQL
      redirect_rules.active = :true AND
      ((source_is_regex = :false AND source_is_case_sensitive = :false AND LOWER(redirect_rules.source) = LOWER(:source)) OR
      (source_is_regex = :false AND source_is_case_sensitive = :true AND #{'BINARY' if connection_mysql?} redirect_rules.source = :source) OR
      (source_is_regex = :true AND (redirect_rules.source_is_case_sensitive = :true AND :source ~ redirect_rules.source) OR
      (redirect_rules.source_is_case_sensitive = :false AND :source ~* redirect_rules.source)))
    SQL
  end
end
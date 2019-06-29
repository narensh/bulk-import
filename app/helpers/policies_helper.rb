module PoliciesHelper

  def self.fetch_or_persist(company_id, names)
    names.map do |name|
      Policy.find_or_create_by({name: name, company_id: company_id})
    end
  end

  def self.fetch_policies(all_policies, required_policy_names)
    required_policies = []
    names_to_array(required_policy_names).map do |required_policy_name|
      required_policies << all_policies.select {|p| p.name == required_policy_name}
    end
    required_policies.flatten!
    required_policies
  end

  def self.names_to_array(names)
    names.to_s.strip.split('|')
  end
end
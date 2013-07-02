if File.exists?('/usr/sbin/lldpctl')
  lldp = Hash.new
  `lldpctl -f keyvalue`.split(/\n/).each do |line|
    key, value = line.split(/=/)
    lldp[key] ||= Array.new
    lldp[key] << value
  end

  lldp_combined = Hash.new

  # things we care about from lldp
  lldp_keys = ['chassis.name', 'port.descr', 'vlan.vlan-id', 'vlan']
  Facter.value('interfaces').split(/,/).each do |interface|
    lldp_keys.each do |lldp_key|
      fact_string = "lldp.#{interface}.#{lldp_key}"
      if lldp.has_key?(fact_string)
        Facter.add(fact_string.gsub(/([.-])/, '_')) do
          setcode do
            lldp[fact_string].uniq.join(',')
          end
        end
        combined_fact_string = "lldp.#{lldp_key}"
        lldp_combined[combined_fact_string] ||= Array.new
        lldp_combined[combined_fact_string] << lldp[fact_string]
      end
    end
  end

  # build a unified fact from all interfaces
  lldp_combined.keys.each do |fact_string|
    Facter.add(fact_string.gsub(/([.-])/, '_')) do
      setcode do
        lldp_combined[fact_string].flatten.uniq.join(',')
      end
    end
  end

end

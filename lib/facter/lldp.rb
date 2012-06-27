if File.exists?('/usr/sbin/lldpctl')
  lldp = Hash.new
  `lldpctl -f keyvalue`.split(/\n/).each do |line|
    key, value = line.split(/=/)
    lldp[key] ||= Array.new
    lldp[key] << value
    lldp[key].uniq!
  end

  # things we care about from lldp
  lldp_keys = ['chassis.name', 'port.descr', 'vlan.vlan-id', 'vlan']
  Facter.value('interfaces').split(/,/).each do |interface|
    lldp_keys.each do |lldp_key|
      fact_string = "lldp.#{interface}.#{lldp_key}"
      if lldp.has_key?(fact_string)
        Facter.add(fact_string.gsub('.', '_')) do
          setcode do
            lldp[fact_string].join(',')
          end
        end
      end
    end
  end
end
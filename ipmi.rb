if File.exists?('/usr/bin/ipmitool')
  Facter.add('bmc_ip_address') do
    setcode do 
      begin
        Timeout::timeout(3) { `ipmitool lan print 1 | grep 'IP Address  ' | cut -d: -f2 | sed 's/ //g'` }
      rescue
        nil
      end
    end
  end
end
NETWORK_STUB = {
  "uuid"=>"e92e60c2-2993-4a0c-b635-c5e2b2462c7a",
  "domainname"=>"p2.tiktalik.com",
  "owner"=>"system",
  "net"=>"37.233.98.0/24",
  "public"=>true,
  "name"=>"pub2"
}

OPERATION_STUB = {
  "code"=>3,
  "add_source"=>"imanel",
  "end_time"=>"2013-05-29 10:39:13 +0200 (UTC)",
  "uuid"=>"ad9a7aa3-dc61-4dde-92de-af335a635041",
  "progress"=>100,
  "end_code"=>0,
  "start_time"=>"2013-05-29 10:38:31 +0200 (UTC)",
  "description"=>"Create_Install: test",
  "end_desc"=>"ok",
  "add_time"=>"2013-05-29 10:38:30 +0200 (UTC)"
}

VPSIMAGE_STUB = {
  "source_vps_size_name"=>nil,
  "create_time"=>"2013-03-25 15:29:51 +0100 (UTC)",
  "uuid"=>"e18aee6c-9548-457e-9c20-7103d454969a",
  "source_vps_size_disk"=>nil,
  "owner"=>"system",
  "is_public"=>true,
  "description"=>"Some description",
  "type"=>"image",
  "source_vps_size"=>nil,
  "name"=>"Centos 6.4 64-bit"
}

VPSNETINTERFACE_STUB = {
  "ip"=>"37.233.98.178",
  "mac"=>"e6:95:e5:4c:99:86",
  "uuid"=>"b5a097ee-a095-47b4-b7c7-4b11100559a7",
  "seq"=>0,
  "network"=>NETWORK_STUB,
  "instance_uuid"=>"71717dfb-3e86-487f-bcf0-01f6856d6bcd"
}

INSTANCE_STUB = {
  "actions_pending_count"=>0,
  "service_name"=>"TC_UNIT_MICRO",
  "interfaces"=>[VPSNETINTERFACE_STUB],
  "actions"=>[OPERATION_STUB],
  "running"=>true,
  "vpsimage"=>VPSIMAGE_STUB,
  "owner"=>"imanel",
  "size"=>-2,
  "uuid"=>"71717dfb-3e86-487f-bcf0-01f6856d6bcd",
  "hostname"=>"test",
  "state"=>12,
  "gross_cost_per_hour"=>0.03321,
  "default_password"=>"c933c94b8b",
  "vpsimage_uuid"=>"e18aee6c-9548-457e-9c20-7103d454969a"
}

shared_context 'optoro_metrics' do
  before do
    allow(Chef::EncryptedDataBagItem).to receive(:load).with('passwords', 'mysql').and_return(
      'id' => 'mysql',
      'sensu' => {
        'name' => 'sensu',
        'password' => 'password'
      }
    )
  end
end

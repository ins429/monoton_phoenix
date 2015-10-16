defmodule Monoton.Uploader do

  def upload!(temp_file_path, filename) do
    :ssl.start()
    :erlcloud.start()
    :erlcloud_s3.configure('AKIAIPNP3QCAHII2SO2A', 'AJ12C4kqt1DkZNnXpx5+IEZ5in6th/QAKaj/Loku')
    {:ok, file} = File.read(temp_file_path)
    :erlcloud_s3.put_object('monoton', filename, file)
  end
end 

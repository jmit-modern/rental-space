class AwsService
  def self.presign(prefix, filename)
    extname = File.extname(filename)
    filename = "#{SecureRandom.uuid}#{extname}"

    data = S3_BUCKET.presigned_post(key: "#{prefix}/${filename}", success_action_status: "201", acl: "public-read")

    return { url: data.url, fields: data.fields }
  end

  def self.upload(file)
    obj = S3_BUCKET.object("uploads/#{SecureRandom.uuid}/#{file.original_filename}")
    obj.put(body: file.to_io, acl: "public-read")
    return obj
  end
end

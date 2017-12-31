raise 'Cannot seed in production' if Rails.env.production?

require 'database_cleaner'
DatabaseCleaner.clean_with(
  :truncation,
  except: %w(ar_internal_metadata),
)

user = User.create!(
  username: 'cjmarkham',
  password: 'password',
  email: 'carl@asf.com',
)

user2 = User.create!(
  username: 'agilmore28',
  password: 'password',
  email: 'amy@asf.com',
)

topic = Topic.create!(
  name: 'Something about games',
  author: user,
  description: 'This is the first post of the topic, This is the first post of the topic',
)

post = Post.create!(
  topic: topic,
  name: 'Something about games',
  author: user,
  content: 'This is the first post of the topic, This is the first post of the topic, This is the first post of the topic, This is the first post of the topic',
)

gaming_tag = Tag.create!(
  name: 'Gaming',
  description: 'For everything about games',
)

taggable = Taggable.create!(
  tag: gaming_tag,
  topic: topic,
)

topic = Topic.create!(
  name: 'Should I get a 60hz monitor?',
  author: user2,
  description: 'This is the content of the topic. It can be quite long, but mostly you will get people writing a few words.',
)

post = Post.create!(
  topic: topic,
  name: 'Should I get a 60hz monitor?',
  author: user2,
  content: 'This is the content of the topic. It can be quite long, but mostly you will get people writing a few words.',
)

tech_tag = Tag.create!(
  name: 'Tech',
  description: 'For everything about technology',
)

taggable = Taggable.create!(
  tag: tech_tag,
  topic: topic,
)

Configuration.create!(
  key: 'board_name',
  value: 'asimpleforum',
)

Configuration.create!(
  key: 'long_date_format',
  value: '%e %B %Y',
)

Configuration.create!(
  key: 'short_date_format',
  value: '%e %b %y',
)

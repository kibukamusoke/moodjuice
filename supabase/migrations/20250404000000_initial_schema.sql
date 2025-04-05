-- Create tables for MoodJuice app

-- Users table (extends Supabase auth users)
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY REFERENCES auth.users ON DELETE CASCADE,
  email TEXT NOT NULL,
  name TEXT,
  avatar_url TEXT,
  has_completed_onboarding BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Moods table to store user mood selections
CREATE TABLE IF NOT EXISTS moods (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  mood TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Juices table to store generated mood juices
CREATE TABLE IF NOT EXISTS juice (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  mood TEXT NOT NULL,
  activity TEXT NOT NULL,
  emoji_cocktail TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Activities table to store random activities
CREATE TABLE IF NOT EXISTS activities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  activity TEXT NOT NULL,
  mood_category TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert some default activities
INSERT INTO activities (activity, mood_category) VALUES
  ('Go touch grass for 5 minutes.', NULL),
  ('Call someone you love.', 'happy'),
  ('Take 3 deep breaths.', 'anxious'),
  ('Dance to your favorite song.', 'happy'),
  ('Try a 5-minute meditation.', 'anxious'),
  ('Write down 3 things you''re grateful for.', 'sad'),
  ('Do 10 jumping jacks right now.', NULL),
  ('Drink a glass of water.', NULL),
  ('Text someone a compliment.', 'happy'),
  ('Look out the window for 2 minutes.', 'thoughtful'),
  ('Stretch your arms above your head.', 'tired'),
  ('Make a silly face in the mirror.', 'sad'),
  ('Listen to a song that matches your mood.', NULL),
  ('Draw your current feeling.', 'thoughtful'),
  ('Hug yourself for 30 seconds.', 'sad'),
  ('Take a power nap (20 minutes max).', 'tired'),
  ('Write down what''s bothering you, then crumple it up.', 'angry'),
  ('Splash cold water on your face.', 'tired'),
  ('Count to 50 really fast.', 'anxious'),
  ('Say "I''ve got this" out loud.', 'anxious');

-- Create RLS policies

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE moods ENABLE ROW LEVEL SECURITY;
ALTER TABLE juice ENABLE ROW LEVEL SECURITY;
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;

-- Users table policies
CREATE POLICY "Users can view their own data" 
  ON users FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own data" 
  ON users FOR UPDATE USING (auth.uid() = id);

-- Moods table policies
CREATE POLICY "Users can insert their own moods" 
  ON moods FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view their own moods" 
  ON moods FOR SELECT USING (auth.uid() = user_id);

-- Juice table policies
CREATE POLICY "Users can insert their own juices" 
  ON juice FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view their own juices" 
  ON juice FOR SELECT USING (auth.uid() = user_id);

-- Activities are public for all authenticated users
CREATE POLICY "Activities are readable by all authenticated users" 
  ON activities FOR SELECT USING (auth.role() = 'authenticated');

-- Also allow anonymous access to activities
CREATE POLICY "Activities are readable by anonymous users" 
  ON activities FOR SELECT USING (true);

-- Create triggers for updated_at

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_modified_column() 
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW; 
END;
$$ LANGUAGE plpgsql;

-- Update trigger for users table
CREATE TRIGGER update_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();
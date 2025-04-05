-- Function to get a random activity based on mood
CREATE OR REPLACE FUNCTION get_random_activity(p_mood TEXT DEFAULT NULL)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
  v_activity TEXT;
BEGIN
  -- If mood is provided, try to get a mood-specific activity first
  IF p_mood IS NOT NULL THEN
    SELECT activity INTO v_activity
    FROM activities
    WHERE mood_category = p_mood
    ORDER BY RANDOM()
    LIMIT 1;
  END IF;
  
  -- If no mood-specific activity was found or no mood was provided, get a generic one
  IF v_activity IS NULL THEN
    SELECT activity INTO v_activity
    FROM activities
    WHERE mood_category IS NULL
    ORDER BY RANDOM()
    LIMIT 1;
  END IF;
  
  -- If still no activity (unlikely with our seed data), provide a default
  IF v_activity IS NULL THEN
    v_activity := 'Take a moment for yourself.';
  END IF;
  
  RETURN v_activity;
END;
$$;

-- Function to create a user profile after signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO public.users (id, email)
  VALUES (NEW.id, NEW.email);
  RETURN NEW;
END;
$$;

-- Trigger the function every time a user signs up
CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();
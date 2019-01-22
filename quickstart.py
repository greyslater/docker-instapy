""" Quickstart script for InstaPy usage """
# insert Project Base Path /Instapy into sys.path because we don't run quickstart.py from the Base path
import sys
sys.path.insert(0, '/InstaPy')

# imports
from instapy import InstaPy
from instapy.util import smart_run

# additional imports random amount of likes and unfollows etc.
import random

# login credentials and definitions
insta_username = ''
insta_password = ''

dont_likes = ['sex','nude','naked','slaughter','pussy']

friends = ['friend1','friend2']

ignored_users = ['ignore1','ignore2']

like_tag_list = [
	'alps',
	'mountains',
	'nature',
	'outside']

# get an InstaPy session!
# set headless_browser=True to run InstaPy in the background
session = InstaPy(username=insta_username,
                  password=insta_password,
                  nogui=True,
                  headless_browser=True)

with smart_run(session):
    """ Activity flow """
    # general settings
    session.set_relationship_bounds(enabled=True,
                                    delimit_by_numbers=True,
                                    max_followers=4590,
                                    min_followers=45,
                                    min_following=77)

    session.set_dont_include(friends)
    session.set_ignore_users(ignored_users)
    session.set_dont_like(dont_likes)
    session.set_delimit_liking(enabled=True, max=5000, min=20)
    session.set_user_interact(amount=3, randomize=True, percentage=80, media='Photo')
    session.set_do_follow(enabled=True, percentage=80)
    session.set_do_like(enabled=True, percentage=100)

    # actions
    session.like_by_tags(random.sample(like_tag_list, 3), amount=random.randint(50, 100), skip_top_posts=False, interact=True)

    session.unfollow_users(amount=random.randint(75, 150), InstapyFollowed=(True, "all"), style="FIFO", unfollow_after=90*60*60, sleep_delay=600)

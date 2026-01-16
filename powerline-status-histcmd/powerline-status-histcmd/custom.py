# vim:fileencoding=utf-8:noet
from __future__ import (unicode_literals, division, absolute_import, print_function)

from powerline.segments import Segment, with_docstring
from powerline.theme import requires_segment_info, requires_filesystem_watcher

@requires_filesystem_watcher
@requires_segment_info
class CustomSegment(Segment):
  divider_highlight_group = None

  def __call__(self, pl, segment_info, create_watcher):
    return [{
      'literal_contents': (6, ' \! \[\033[0;30;44m\]'),
      'highlight_groups': ['information:regular'],
      }]

histcmd = with_docstring(CustomSegment(), '''Return a custom segment.''')

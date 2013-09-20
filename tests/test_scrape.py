from unittest2 import TestCase

from datalogy.scrape import scrape


class ScrapeTestCase(TestCase):

    def test_scrape(self):
        output = """
        <table class="wikitable"><tr><td><b>
        <a href="/wiki/Afghanistan" title="Afghanistan">Afghanistan</a></b>
        </td></tr></table>
        """
        html, expression, text, body, delimiter = (
            output,
            'table.wikitable > tr > td > b > a',
            False,
            False,
            None
        )

        self.assertEqual(
            '<a href="/wiki/Afghanistan" title="Afghanistan">Afghanistan</a>\n',
            scrape(html, expression, text, body, delimiter)[0]
        )

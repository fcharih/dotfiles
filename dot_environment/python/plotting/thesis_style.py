import os
from pathlib import Path

from cycler import cycler
import matplotlib
import matplotlib.font_manager as font_manager


def setup_style():

    # Load a font from TTF file,
    # relative to this Python module
    # https://stackoverflow.com/a/69016300/315168
    font_path = f"{Path.home()}/.environment/fonts/LibertinusSans-Regular.ttf"
    fontit_path = f"{Path.home()}/.environment/fonts/LibertinusSans-Italic.ttf"
    assert os.path.exists(font_path)
    font_manager.fontManager.addfont(font_path)
    font_manager.fontManager.addfont(fontit_path)
    prop = font_manager.FontProperties(fname=font_path)

    #  Set it as default matplotlib font
    matplotlib.rc("font", family="sans-serif")
    matplotlib.rc("mathtext", fontset="custom")
    matplotlib.rcParams.update(
        {
            "font.size": 16,
            "font.sans-serif": prop.get_name(),
            "axes.autolimit_mode": "round_numbers",
            "legend.fancybox": False,
            "legend.frameon": False,
            "legend.fontsize": "small",
            "scatter.edgecolors": "black",
            "figure.autolayout": True,
            "figure.dpi": 300,
            "errorbar.capsize": 3,
            "axes.axisbelow": True,
            "axes.spines.top": False,
            "axes.spines.right": False,
            "axes.xmargin": 0,
            "axes.ymargin": 0,
        }
    )

    matplotlib.rc(
        "axes",
        prop_cycle=(
            cycler(
                color=[
                    "#84C3E4",
                    "#AA4499",
                    "#127833",
                    "#999934",
                    "#2F207E",
                    "#CD6677",
                    "#882255",
                    "#43A898",
                    "#DDCB77",
                ]
            )
        ),
    )
    # matplotlib.rcParams["mathtext.fontset"] = "custom"


def separate_thousands(ax, x_axis=True, y_axis=True, sep=','):
	if x_axis:
		ax.get_xaxis().set_major_formatter(
		matplotlib.ticker.FuncFormatter(lambda x, p: format(int(x), sep))
		)
	if y_axis:
		ax.get_yaxis().set_major_formatter(
		matplotlib.ticker.FuncFormatter(lambda x, p: format(int(x), sep))
	)

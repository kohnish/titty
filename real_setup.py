from setuptools import setup, find_packages

setup(
        name='titty',
        version='0.1.0',
        packages=["titty", "titty/kitty", "titty/kitty/conf", "titty/kitty/options", "titty/kitty/layout", "titty/kitty/fonts"],
        package_data={'': ['*.so', '*.glsl']},
        include_package_data=True,
        entry_points={
            'console_scripts': [
                'titty=titty:titty_main',
            ]
        }

)

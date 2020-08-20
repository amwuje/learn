# -*- coding: utf-8 -*-
"""
Created on Thu Aug 20 16:46:44 2020

@author: huang
"""

import os
import sys
import subprocess

def get_manifest_xml_path():
    xml_path = input()
    if os.path.exists( xml_path ):
        return xml_path
    else:
        print('AndroidManifest.xml not found!')


def get_out_path( xml_path ):
    return os.path.dirname( os.path.abspath( xml_path ) ) + os.sep + 'AndroidManifest.txt'


def convert_xml_to_txt( xml_path, out_path ):
    convert_cmd = 'java -jar AXMLPrinter2.jar %s>%s' % ( xml_path, out_path )
    subprocess.Popen( convert_cmd, shell=True )

if __name__ == "__main__":
    xml_path = get_manifest_xml_path()
    out_path = get_out_path( xml_path )
    convert_xml_to_txt( xml_path, out_path )


    
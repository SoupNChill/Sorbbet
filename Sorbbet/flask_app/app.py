from flask import Flask, render_template, request, redirect, url_for
import subprocess

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/status')
def status():
    # Call your C program or script to get status information
    return render_template('status.html')

@app.route('/migrate', methods=['POST'])
def migrate():
    src_path = request.form.get('src_path')
    dest_path = request.form.get('dest_path')
    subprocess.run(['sorbbet', '--migrate', src_path, dest_path])
    return redirect(url_for('status'))

@app.route('/snapshot', methods=['POST'])
def snapshot():
    file_path = request.form.get('file_path')
    subprocess.run(['sorbbet', '--snapshot', file_path])
    return redirect(url_for('status'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

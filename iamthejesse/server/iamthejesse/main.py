from flask import Flask, json, jsonify, request, session
app = Flask(__name__)
app.config['SECRET_KEY'] = 'dev key'

status = 0 # current progress state


events = [
        {
            "messages" : [{
                "type":"say",
                "content":"So you think you are THE Jesse?"
            },
            {
                "type":"say",
                "content":"blah 1"
            },
            {
                "type":"ask",
                "content":"http://craigslist.com"
            },
            {
                "type":"ask",
                "content":"What is your name?"
            }],
            "answer" : 'jesse'
        },
        {
            "messages" : [{
                "type":"say",
                "content":"now we know you MAYBE Jesse?"
            },
            {
                "type":"say",
                "content":"blah 1"
            },
            {
                "type":"ask",
                "content":"Who is a banana?"
            }],
            "answer" : 'iama'
        }
    ]

@app.route("/update", methods=['POST', 'GET'])
def update():
    if not 'status' in session:
        session['status'] = 0
        session['times'] = 0
    else:
        # update is called during an active session
        # means navigation witout answering the question
        session['times'] = session['times'] + 1

    return jsonify(get_update(0, session['times']))

    if request.json:
        status.from_dict(request.json)
        session.commit()

@app.route("/answer", methods=['POST'])
def answer():
    if not 'status' in session:
        session['status'] = 0
        session['status'] = 0

    event_no = session['status']
    if request.json:
        if 'answer' in request.json:
            if answer.strip().lower() == events[event_no].answer:
                if event_no > len(events):
                    # TODO: SOME CELEBRATION
                    pass
                
                # Correct answer, update status, reset times
                # and send new question
                event_no = event_no + 1
                # get new question
                update = get_update(event_no, session['times'])

                # update cookie and send response
                session['status'] = event_no
                session['times'] = 0

                return jsonify(update)
            else:
                # incorrect answer, increment times
                session['times'] = session['times'] + 1


def get_update(event_no, times):
    event = events[event_no]
    update = {}

    update['times'] = times
    update['events'] = event['messages']

    return update


@app.route("/", methods=['GET'])
def index():

    for event in events:
        print event
    return jsonify()

@app.after_request
def after_request(response):
    if response.status_code < 300:
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Allow-Methods'] = 'OPTIONS, GET, POST, PUT, DELETE'
        response.headers['Access-Control-Allow-Headers'] = 'Content-Type, User-Agent, X-Requested-With, Cache-Control'

    return response


from questions import events
from flask import Flask, json, jsonify, request, session
app = Flask(__name__)
app.config['SECRET_KEY'] = 'dev key'

status = 0 # current progress state

@app.route("/update", methods=['POST', 'GET'])
def update():
    if not 'status' in session:
        session['status'] = 0
        session['times'] = 0
    else:
        # update is called during an active session
        # means navigation witout answering the question
        session['times'] = session['times'] + 1

    #shouldn't always send number 0
    event_no = session['status']
    times = session['times']
    
    print 'update', session
    return jsonify(get_question(event_no, times))

@app.route("/answer", methods=['POST'])
def answer():
    print 'answer', session
    if not 'status' in session:
        session['status'] = 0
        session['times'] = 0

    event_no = session['status']
    if request.json:
        if 'answer' in request.json:
            if events[event_no]['verifier'](request.json['answer']):
                if event_no > len(events):
                    # TODO: SOME CELEBRATION
                    pass
                
                # get correct messages, includes next question
                correct = get_correct(event_no, session['times'])

                # Correct answer, update status, reset times
                # and send new question
                event_no = event_no + 1

                # update cookie and send response
                session['status'] = event_no
                session['times'] = 0

                print 'update', session
                return jsonify(correct)
            else:
                # incorrect answer, increment times
                session['times'] = session['times'] + 1
                incorrect = get_incorrect(event_no, session['times'])
                print 'update', session
                return jsonify(incorrect)

def get_question(event_no, times):
    """just gets the questions to send"""
    if event_no >= len(events):
       return {}

    event = events[event_no]
    update = {}

    update['times'] = times
    update['events'] = event['question']

    return update

def get_incorrect(event_no, times):
    """gets the incorrect messages and also resends the question"""
    if event_no >= len(events):
       return {}

    event = events[event_no]
    update = {}

    update['times'] = times
    update['events'] = event['incorrect']

    current_question = get_question(event_no, times)
    if current_question.has_key('events'):
       for q in current_question['events']:
          update['events'].append(q)

    return update

def get_correct(event_no, times):
    """gets the correct messages and also sends the next question"""
    if event_no >= len(events):
       return {}

    event = events[event_no]
    update = {}

    update['times'] = times
    update['events'] = event['correct']

    next_question = get_question(event_no+1, times)
    if next_question.has_key('events'):
       for q in next_question['events']:
          update['events'].append(q)

    return update


@app.route("/", methods=['GET'])
def index():
    for event in events:
        print event
    return jsonify()

@app.after_request
def after_request(response):
    if response.status_code < 300:
        response.headers['Access-Control-Allow-Origin'] = request.headers['Origin']
        response.headers['Access-Control-Allow-Methods'] = 'OPTIONS, GET, POST, PUT, DELETE'
        response.headers['Access-Control-Allow-Headers'] = 'Content-Type, User-Agent, X-Requested-With, Cache-Control'
        response.headers['Access-Control-Allow-Credentials'] = 'true'

    return response


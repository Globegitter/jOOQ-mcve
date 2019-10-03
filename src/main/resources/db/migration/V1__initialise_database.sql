CREATE TYPE event_type AS ENUM ('MATCH', 'MARKET', 'OUTCOME');

CREATE TABLE event
(
    id bigserial NOT NULL,
    idempotency_id text NOT NULL UNIQUE,
    timestamp timestamptz NOT NULL,
    stream_id text NOT NULL,
    data jsonb NOT NULL,
    type event_type NOT NULL,
    created_at timestamptz NOT NULL DEFAULT (now() AT TIME ZONE 'utc'),
    PRIMARY KEY (id)
);

-- [jooq ignore start]
CREATE INDEX idx_event_stream_id ON event (stream_id);
CREATE INDEX idx_event_timestamp ON event (timestamp ASC);
-- [jooq ignore stop]
